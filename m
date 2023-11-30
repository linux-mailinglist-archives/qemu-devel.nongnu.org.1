Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639C7FEC99
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:12:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8e1L-0006s3-CO; Thu, 30 Nov 2023 05:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8e1J-0006rb-3n
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8e1H-0000e3-Fy
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701339101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3m5jtYVSEq/m7xMWoWi0vob7HBS4vCGDQOOL/4bNOw=;
 b=LhJN0xIF+ovvyIDOgWiTL3bOciF4h+WThX1NkkMmXqYQF0tV1cArDByy/5JvgwA+nPuyG2
 KPvX4Y2iVhl2bsmPB22iBkd3iZiBDYfAbGR4d+lqiFN4m7+Upi555Pi6sk2KVJHIhw59Vl
 BktUo9Y+9pxRe9VcIz8T0fRkaZTS9Ks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-KWUBmLojNbmTJE3UDBZXXA-1; Thu, 30 Nov 2023 05:11:33 -0500
X-MC-Unique: KWUBmLojNbmTJE3UDBZXXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05794185A787;
 Thu, 30 Nov 2023 10:11:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D30752026D4C;
 Thu, 30 Nov 2023 10:11:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E382621E6A1F; Thu, 30 Nov 2023 11:11:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-block@nongnu.org,  hare@suse.de,  David
 Hildenbrand <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Keith Busch <kbusch@kernel.org>,  Hanna Reitz
 <hreitz@redhat.com>,  dmitry.fomichev@wdc.com,  Kevin Wolf
 <kwolf@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org
Subject: Re: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
References: <20231127085641.3729-1-faithilikerun@gmail.com>
Date: Thu, 30 Nov 2023 11:11:31 +0100
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com> (Sam Li's message
 of "Mon, 27 Nov 2023 16:56:34 +0800")
Message-ID: <874jh3czzg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Sam Li <faithilikerun@gmail.com> writes:

> ZNS emulation follows NVMe ZNS spec but the state of namespace
> zones does not persist accross restarts of QEMU. This patch makes the
> metadata of ZNS emulation persistent by using new block layer APIs and
> the qcow2 img as backing file. It is the second part after the patches
> - adding full zoned storage emulation to qcow2 driver.
> https://patchwork.kernel.org/project/qemu-devel/cover/20231127043703.49489-1-faithilikerun@gmail.com/

In the future, also add this information the machine-readable way,
i.e. like

  Based-on: <20231127043703.49489-1-faithilikerun@gmail.com>

However, it doesn't apply on top of that series for me.  Got something I
could pull?

[...]



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380482BFFB
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 13:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOGyI-0003tS-FJ; Fri, 12 Jan 2024 07:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rOGyD-0003p0-BE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1rOGyA-0002tn-Md
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 07:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705063743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBuPai8n8EA2p+Y8Ni/9TOwzDprz/ob+17rGM97r9Io=;
 b=bs7vyELZrjHu7ao5LD9/Fj9oskA6XA4DcCmv6tqt1EIX3vYDnLqgiMvLdZjYTBvDvyxOSL
 OI+XLgthnKOJEV2+4I1lyN2avr+GrFAef7oHrIbAgUXEp0RVufUwhKUZwJf/FwrGG520/R
 4sknXKPa60CIvtLep3nhMinvGjyhgaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-EnM6pHTfPdSjofwuuRxpuw-1; Fri, 12 Jan 2024 07:48:58 -0500
X-MC-Unique: EnM6pHTfPdSjofwuuRxpuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD8FB185A783;
 Fri, 12 Jan 2024 12:48:57 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBF4C1C0652C;
 Fri, 12 Jan 2024 12:48:54 +0000 (UTC)
Date: Fri, 12 Jan 2024 13:48:52 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/2] ppc: Rename power5+ and power7+ for the new QOM
 naming rules
Message-ID: <ZaE1NOjbFeWyxIeQ@angien.pipo.sk>
References: <20240111164652.908182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111164652.908182-1-thuth@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 11, 2024 at 17:46:50 +0100, Thomas Huth wrote:
> We can get rid of the "power5+" / "power7+" hack in qom/object.c
> by using CPU aliases for those names instead (first patch).
> 
> I think in the long run, we should get rid of the names with a "+"
> in it completely, so the second patch suggests to deprecate those,
> but I'd also be fine if we keep the aliases around, so in that case
> please ignore the second patch.
> 
> Thomas Huth (2):
>   target/ppc/cpu-models: Rename power5+ and power7+ for new QOM naming
>     rules
>   docs/about: Deprecate the old "power5+" and "power7+" CPU names

libvirt seems to be explicitly referencing power7+ in the code, so I
guess we'll need code to translate the + versions to the spellt-out
version to preserve compatibility.



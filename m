Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A7831BE0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:57:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTpK-0007ls-Kz; Thu, 18 Jan 2024 09:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQTpI-0007ke-KY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:57:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQTpH-0002AJ-7L
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705589822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LYEuvVNL3ejLSEBClVEEeru54w2Ey8wRsGgH9PgLZU=;
 b=dZRCSLQCGQVwgoiYM3U2w0S2X5nIe06EkzV+Xgfv+yQqaRx1zna9NXSofpUD2VL6fBleYq
 UoOAAOI930ilJyhbyOLe4VRDFvoAS9NhfgJtgH2m1dCMVm8y8jx/zs7b/b2VHUI0Av/vDU
 lOD8NrZq3KdUOUkVRsnWdf4lImri0yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-0JlFTRDjPkOOG7zMLGQslA-1; Thu, 18 Jan 2024 09:56:55 -0500
X-MC-Unique: 0JlFTRDjPkOOG7zMLGQslA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4299110AFA00;
 Thu, 18 Jan 2024 14:56:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DDB311201;
 Thu, 18 Jan 2024 14:56:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E4D921E680D; Thu, 18 Jan 2024 15:56:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Warner Losh <imp@bsdimp.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Kyle
 Evans <kevans@freebsd.org>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,  devel@lists.libvirt.org,  Laurent Vivier
 <laurent@vivier.eu>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/3] qapi/hmp/cli: Remove the deprecated 'singlestep'
In-Reply-To: <20240117151430.29235-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 17 Jan 2024 16:14:27
 +0100")
References: <20240117151430.29235-1-philmd@linaro.org>
Date: Thu, 18 Jan 2024 15:56:53 +0100
Message-ID: <87le8madvu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Deprecated for 8.1, good to go for 9.0.
>
> Based-on: <20240112100059.965041-5-thuth@redhat.com>
>           "Remove deprecated command line options"

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>



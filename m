Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DABA13E44
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 16:53:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSBI-0006YD-UH; Thu, 16 Jan 2025 10:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tYSBE-0006Sp-2O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tYSB8-00078U-9K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737042785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEPXaGN/dshRyPBUgkJpr1GdSH6Oq6CrLwOaxlFfTmc=;
 b=iI/GZA/IOlaX2C3GAyHJ0zPx2SGQextWeao34oDpfZh/Bb+gc5vSfVioItgDn+42RGbxwO
 vDGAHPI7fc15ECWwC5eyl+LaggabAMyCVDdxWbtrpHXd+LDgB7KaSR/Zaz64FKLrXpNrQ3
 2z4i8/iPka3UAn5R4ga+l2P7bGeY8uw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-gCAsdwbEPOa-Rd3NukHhFg-1; Thu,
 16 Jan 2025 10:53:00 -0500
X-MC-Unique: gCAsdwbEPOa-Rd3NukHhFg-1
X-Mimecast-MFC-AGG-ID: gCAsdwbEPOa-Rd3NukHhFg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F8521956055; Thu, 16 Jan 2025 15:52:58 +0000 (UTC)
Received: from localhost (unknown [10.39.195.205])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27838195608A; Thu, 16 Jan 2025 15:52:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Hilber <quic_philber@quicinc.com>, "Mohamed Abuelfotoh, Hazem"
 <abuehaze@amazon.com>, paul <paul@xen.org>, David Woodhouse
 <dwmw@amazon.co.uk>
Subject: Re: [PATCH v7 1/3] linux-headers: Add vmclock-abi.h
In-Reply-To: <20250116140315.2455143-2-dwmw2@infradead.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-2-dwmw2@infradead.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 16 Jan 2025 16:52:53 +0100
Message-ID: <87tt9y92ne.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 16 2025, David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> This isn't a Linux-specific ABI but Linux does export the header file
> with its definition, so import it from there instead of creating our own.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Cornelia Huck <cohuck@redhat.com>



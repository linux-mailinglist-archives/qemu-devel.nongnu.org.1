Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5C9349E7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 10:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMWu-0007yw-51; Thu, 18 Jul 2024 04:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUMWn-0007fy-Rf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUMWl-0003I3-PC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721291414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RStt/h0TVa29W3A6ePLP6aLkPjmcwqZxsvujCkuw51U=;
 b=Z6yN1O83564hb3YCCWgzLfpsjxZ6iZee/RU6Ykrua+PnM7D1ecdqEI0RYQvktW9H1MCf4w
 N9+5+2hwy7QGBLXpSELEocIs8+s3UdT//7fgqqBpKs8Op4K5EWf2If7VCJuSNGg3iop7Yi
 EH4peG0XfTkf/jFM6VTvheBThdPRvKA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-HeLcppDXPGuW2l-x9UeWKg-1; Thu,
 18 Jul 2024 04:30:10 -0400
X-MC-Unique: HeLcppDXPGuW2l-x9UeWKg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DFB1955D4A; Thu, 18 Jul 2024 08:30:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ED021955D48; Thu, 18 Jul 2024 08:30:06 +0000 (UTC)
Date: Thu, 18 Jul 2024 09:30:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v4 1/3] docs/interop/firmware.json: add new enum
 FirmwareFormat
Message-ID: <ZpjSi9a8pleWJjK-@redhat.com>
References: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
 <20240718-qapi-firmware-json-v4-1-449ce672db5c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240718-qapi-firmware-json-v4-1-449ce672db5c@linutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jul 18, 2024 at 10:27:38AM +0200, Thomas Weißschuh wrote:
> Only a small subset of all blockdev drivers make sense for firmware
> images. Introduce and use a new enum to represent this.
> 
> This also reduces the dependency on firmware.json from the global qapi
> definitions.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



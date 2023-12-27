Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A581F1F8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 21:47:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIanS-0002a0-9j; Wed, 27 Dec 2023 15:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rIanO-0002ZI-SK
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rIanN-0007Sb-BG
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 15:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703709987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETSoQRxfgvbQsUGVfMARPpHrfpkDsi6rR1IIAc9SXNw=;
 b=CdFHKSWSQ5kwCd1VHerdaUykcZq7yL5krZdrU4GsJbziW0XQ3AfBkwwJpSE4npkX/0miPk
 I4yqGCXJxNxgwXM6sUwFuu+/kKacoa7ip1LSAtWAg8bTHJkmCdywIV+rjCqrQm9IY027Oi
 sbAP4DpcJRaeFyoCh/PETAc1uOjpA4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-GzmhH7IxPYOmPgISYFrYZw-1; Wed, 27 Dec 2023 15:46:26 -0500
X-MC-Unique: GzmhH7IxPYOmPgISYFrYZw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d44d9dae3so53380955e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 12:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703709983; x=1704314783;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETSoQRxfgvbQsUGVfMARPpHrfpkDsi6rR1IIAc9SXNw=;
 b=sZyhQscgl9+dIqYuSZdHQ2i3beLfHNQTvzJW9jdzmxoKSMIE7s9QJb3I+HHqCE4zcE
 rSVlDEA37+GwNTCumgVPI8l/rdeYRZgpYyn8ZDobcfow4xiHsTmWa7k40dJAVLG8B886
 Gp5j7G2Q2186WhOuoPz0R8KwiqxE17m823JqqGG/AgFkvyD8gc3T1a0GHBvgUjyt1jBy
 D2D+Md6rQEISgq2ch+PBAVeoVz+Z9ahnos+0z5SBGfGHIpJcujP224GnpMgcwcDtzexf
 KoARjlDhOv2lTh3bXpZF4FMDVlR3nOnk49dgXezE08XhgwsoKwOPWcD2ZNQeuxZRAreV
 X2Gw==
X-Gm-Message-State: AOJu0Yx80IIgP4gvSi+HwEFsAvwD2VGS6X5EgDIA0vzGzM7ih7IDr+aY
 lfvrGqM4Foqm5kqHxYv5b5B+o8xkl/Za56dgmUx8iZSiMljVdnR6WljVooA/CgXI0U5uLLLUWxp
 aRkKoNG2CHjANMVSnb4Gjkqg=
X-Received: by 2002:a05:600c:3d8a:b0:40d:54a0:29ce with SMTP id
 bi10-20020a05600c3d8a00b0040d54a029cemr2947553wmb.133.1703709982999; 
 Wed, 27 Dec 2023 12:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOg5pnHMb6g7uRWA+2wauaFdkDulAIcmWbfUnDij749D0a6xHeNCmxQJQ6CFmWnRMRA0neGQ==
X-Received: by 2002:a05:600c:3d8a:b0:40d:54a0:29ce with SMTP id
 bi10-20020a05600c3d8a00b0040d54a029cemr2947547wmb.133.1703709982647; 
 Wed, 27 Dec 2023 12:46:22 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b0040d5335079dsm14836616wmb.47.2023.12.27.12.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 12:46:21 -0800 (PST)
Date: Wed, 27 Dec 2023 15:46:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Gabriel Somlo <somlo@cmu.edu>, kernel@pengutronix.de,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] firmware: qemu_fw_cfg: Convert to platform remove
 callback returning void
Message-ID: <20231227154549-mutt-send-email-mst@kernel.org>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
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

On Wed, Dec 27, 2023 at 05:26:30PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I don't mind.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/firmware/qemu_fw_cfg.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 1448f61173b3..03da9a4354f8 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -731,7 +731,7 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int fw_cfg_sysfs_remove(struct platform_device *pdev)
> +static void fw_cfg_sysfs_remove(struct platform_device *pdev)
>  {
>  	pr_debug("fw_cfg: unloading.\n");
>  	fw_cfg_sysfs_cache_cleanup();
> @@ -739,7 +739,6 @@ static int fw_cfg_sysfs_remove(struct platform_device *pdev)
>  	fw_cfg_io_cleanup();
>  	fw_cfg_kset_unregister_recursive(fw_cfg_fname_kset);
>  	fw_cfg_kobj_cleanup(fw_cfg_sel_ko);
> -	return 0;
>  }
>  
>  static const struct of_device_id fw_cfg_sysfs_mmio_match[] = {
> @@ -758,7 +757,7 @@ MODULE_DEVICE_TABLE(acpi, fw_cfg_sysfs_acpi_match);
>  
>  static struct platform_driver fw_cfg_sysfs_driver = {
>  	.probe = fw_cfg_sysfs_probe,
> -	.remove = fw_cfg_sysfs_remove,
> +	.remove_new = fw_cfg_sysfs_remove,
>  	.driver = {
>  		.name = "fw_cfg",
>  		.of_match_table = fw_cfg_sysfs_mmio_match,
> -- 
> 2.43.0



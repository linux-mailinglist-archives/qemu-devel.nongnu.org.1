Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E997CF679
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtR1g-0001Kc-Vs; Thu, 19 Oct 2023 07:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtR1U-0001J6-GX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtR1S-0006M8-Tc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LVHCi0nyNMFqvzSSs9uBLoe0Rh0KSOWlVGIaPnUN5Dw=;
 b=ahrPiPaM2wPu9pHpvSquNMCxPsGQxs5hOreCAz3VvNkNykhNyuxP7i4dD1waZPguHzcAyF
 qZEEiaNbGHH1uNF87pTfr9q7qc0kKUpj+1dAhs4ndBkHEVj5CvhcxhzyEGuOjzLW1riOk3
 4tOuU6/pXyD1iXA8nyBuhMh3pktnFw8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-TF2_HZDqMCeSTLS5urZpvA-1; Thu, 19 Oct 2023 07:15:36 -0400
X-MC-Unique: TF2_HZDqMCeSTLS5urZpvA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so2567874f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714135; x=1698318935;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVHCi0nyNMFqvzSSs9uBLoe0Rh0KSOWlVGIaPnUN5Dw=;
 b=o5ZpPrMNnT7MxeUlMflYnt1upZsKjxNmi3g5kSQt9uhAW+RhdYNOurfEEG7hGYqhgO
 APtkW//CgqyAh26ob1/nRKBjnD/WAPY+5whwX5XZ56Ml8ErVTOYoyACgmmj6zISFPNuJ
 yp19ijxL8XBNWLFnn1+XqDE9hUbMiZDvSUSBxOEiDsh7ECEBp9zXeMPftLYRJNiAMSjb
 f9QYvLAqRgQSh9jN0yn9QqTEiQ+p+XpaHY6WGNAURNBM1G3MIr5sYjher0+F6TWsAlzD
 JWA3Xh8fnwy7U4PiQVVVnUcGi0EvoVNF3Kmad92ixPeUH6tQbOE2jbKh+xhTKG+UfWgA
 oSdw==
X-Gm-Message-State: AOJu0YxQu3uy8/2fBuhVnqpKVd03n5rJvSGSEU6Vr2v0eNflTQekB7a0
 BvJwmE11ohBgav9LFsLO5ntxBknnA3S6UfYPkvredQgb2/M60Rd8sQiqK15v2xHO3IkSECqt/xB
 C2+F7Q4opPl/hY+E=
X-Received: by 2002:adf:e944:0:b0:32d:9a88:e36 with SMTP id
 m4-20020adfe944000000b0032d9a880e36mr1533527wrn.2.1697714135754; 
 Thu, 19 Oct 2023 04:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERVjyrjx+EjDaW7eM7zr1mxpgayQHCS9aRbZI+aXtZWnrdImxd6V/ZUh+yybQR9+BTs8Rcuw==
X-Received: by 2002:adf:e944:0:b0:32d:9a88:e36 with SMTP id
 m4-20020adfe944000000b0032d9a880e36mr1533511wrn.2.1697714135440; 
 Thu, 19 Oct 2023 04:15:35 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j4-20020a5d4524000000b00317a04131c5sm4275353wra.57.2023.10.19.04.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:15:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 2/5] qapi/migration: Introduce compress-with-iaa
 migration parameter
In-Reply-To: <20231018221224.599065-3-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:21 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-3-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:15:34 +0200
Message-ID: <87ttqm6ey1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Yuan Liu <yuan1.liu@intel.com> wrote:
> Introduce the compress-with-iaa=on/off option to enable or disable live
> migration data (de)compression with the In-Memory Analytics Accelerator
> (IAA).
>
> The data (de)compression with IAA feature is based on the migration
> compression capability, which is enabled by setting
> migrate_set_capability compress on. If the migration compression
> capability is enabled and the IAA compression parameter is set, IAA will
> be used instead of CPU for data (de)compression.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

> @@ -724,6 +726,13 @@ int migrate_compress_threads(void)
>      return s->parameters.compress_threads;
>  }
>  
> +bool migrate_compress_with_iaa(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.compress_with_iaa;
> +}
> +

This should be in migration/options.c



> @@ -77,6 +77,7 @@ uint8_t migrate_cpu_throttle_increment(void);
>  uint8_t migrate_cpu_throttle_initial(void);
>  bool migrate_cpu_throttle_tailslow(void);
>  int migrate_decompress_threads(void);
> +bool migrate_compress_with_iaa(void);
>  uint64_t migrate_downtime_limit(void);
>  uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);

This list of functions is sorted.  The same in the migration/options.c.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278170EF2C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ii5-00056Y-I6; Wed, 24 May 2023 03:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ihy-00056C-Qj
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ihx-0004JZ-6g
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684912492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmlAEAprx89+aMInVWr7/sxZvdx9m/YcT2e3c2Ksl0s=;
 b=JqvLgD+BKGGEIQ2E/PrNoHXJBWTTR0KVi9fEuJbUDH77yvjTDbVN5IUjsm1OQOWmDv1Qkl
 fuKz1sdCN5eEoGtWVfOoiYi/XxXSphnd6OwQCLFD0VGZLbDJqCnpV7s+Xht5Lqr85rN39j
 mOQYAqeyy751LbmapmzPlcl8/OScA60=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-dr0WXcF7MAO-1JRCeakjyQ-1; Wed, 24 May 2023 03:14:51 -0400
X-MC-Unique: dr0WXcF7MAO-1JRCeakjyQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so668719a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684912490; x=1687504490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmlAEAprx89+aMInVWr7/sxZvdx9m/YcT2e3c2Ksl0s=;
 b=IsJIVDF3cv/jnXUODUAhGRZmjeaO9II0mFULKL7xRpp/t4xLSVh/enYFq0Uh1I3eOd
 wjH3rhyzb7rK1XOAZ7fvZTI6Poy4BqljL77XOSnoys/XfR3jkBhI4dtGYt5opspqedMA
 1d+uWdUIq62yQGxim3vXoot5V366dhaeO812nbO8xH3sCMJslSPQpWLC1nmqLESlHRJY
 l5eWdlgmVDgg1e/ez9xh+bzFY7H2spv+tJxSkd3PzbA3DTbEiQ3U0aULzsAiR3SYVtbt
 3T6bui9jut4N5TZCYZxsTeeikTzry3BbJ46YEvwU1J3dBpqdqW98ghwHEHkbsbQTvGEe
 1ZlA==
X-Gm-Message-State: AC+VfDxrBFSyf1+uR8QZ+ai/+cYwKvSPiJWrC74GgxcEASxR17PwW/Iy
 2rqxECdg1jgDLaGp3IFPQg6LSCorqkwHwdAh4j9AGV0pPPY9VXlRVLeqG2xhVI8Gz6SRurc06ru
 3ae6w/01m/4gTsZo=
X-Received: by 2002:a17:906:7087:b0:965:fa3b:7478 with SMTP id
 b7-20020a170906708700b00965fa3b7478mr13500934ejk.53.1684912490141; 
 Wed, 24 May 2023 00:14:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FeeVeD12M4JQPh0l5QnylSsUknzhsR+JTV9hpt+hR+7NezTXE12KygPiW/To8Jd7B54jxSw==
X-Received: by 2002:a17:906:7087:b0:965:fa3b:7478 with SMTP id
 b7-20020a170906708700b00965fa3b7478mr13500896ejk.53.1684912489850; 
 Wed, 24 May 2023 00:14:49 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 w20-20020a170907271400b0096a16761ab4sm5467518ejk.144.2023.05.24.00.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:14:49 -0700 (PDT)
Message-ID: <504ff9c7-9dce-2a8f-9bd1-fdd893faeed6@redhat.com>
Date: Wed, 24 May 2023 09:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/11] hw/scsi: Rearrange meson.build
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> We will modify this file shortly. Re-arrange it slightly first,
> declaring source sets first.
> 
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/meson.build | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
> index fa9198e69f..f3206a4756 100644
> --- a/hw/scsi/meson.build
> +++ b/hw/scsi/meson.build
> @@ -1,4 +1,7 @@
>   scsi_ss = ss.source_set()
> +specific_scsi_ss = ss.source_set()
> +virtio_scsi_ss = ss.source_set()
> +
>   scsi_ss.add(files(
>     'emulation.c',
>     'scsi-bus.c',
> @@ -11,18 +14,13 @@ scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
>   scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
>   scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
>   scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
> -softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
>   
> -specific_scsi_ss = ss.source_set()
> -
> -virtio_scsi_ss = ss.source_set()
>   virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
> -
>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
>   virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
> +specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
>   specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)

I think it might still make sense to keep the virtio stuff together, i.e. 
add the SPAPR line after the VIRTIO_SCSI line instead of adding it in front 
of it?

  Thomas


> -specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
> -
> +softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
>   specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)



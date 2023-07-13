Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE07529F8
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK0H8-0005Sb-Nh; Thu, 13 Jul 2023 13:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qK0H5-0005SJ-Nr
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qK0H3-0007A8-OP
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689269914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsjQwki7XZbc91OAZ+06s4VY5uvkouZS889NYX9gzL0=;
 b=PaKd80jORcJfy15SBU6bmxzJKnoMIgiQSTzcYTIJE9iVQKkD3go101FRL+O0zIW7erG+vS
 HQXm9F6GC4qFAeM9vE+4jbmjISPPkYCnvmFiiJmY+PL+9blAFKyh6lpR7D4QcT0MszA3JP
 Exm1WLUd61o6cwgh/tvdMgnnN99THPc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-EdKoB84hMiGPvyuW0PU7UA-1; Thu, 13 Jul 2023 13:38:33 -0400
X-MC-Unique: EdKoB84hMiGPvyuW0PU7UA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635e3871cf9so7518196d6.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689269909; x=1689874709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsjQwki7XZbc91OAZ+06s4VY5uvkouZS889NYX9gzL0=;
 b=lSBRKwr/2Cug7NdIeZtGiQiu6LsRJbyN06JfBbrzFLiSIAhzGvPro9WErRGFsVW6+I
 7el8hCMjQWI/7FzwnJRNWqU3X0rq5n4M9IfZyQJ2mLo1VWbN2t557VMm7Rp3+ixSPtsT
 7bbblW1ZIS2pF+hsEMufUMcBq/fPCpeifbxrMBssh9ca3JRv9neDLPraUkTrLLc4q2Mb
 2ZD4ys1eCzjVTFabSdZQh5SutN6L5ALBZGhjtIr7DwtGNgS9RWXpWLab/7FqAHI2IzGQ
 ifvD16Sm49V0MHeVGNgFaqHETBjy4lFKugJKW4TBybNVc0hUhmRn5PSQkjFOSm6KhsXS
 b7CQ==
X-Gm-Message-State: ABy/qLbPp5OcC+x/m7wy6pE2P9PsX1Km1LCNv40II/HuvCN/DqYExlTP
 cyeJ0RXmyGHHXTR1R/Rd9MEemqgpiQSDPgFIDv8YZZjEdpqw3lUrUnlPp7dkh1AP87yd5Mz9eUw
 8lFt2goEiPTP7Zn4=
X-Received: by 2002:a0c:f1c9:0:b0:635:f48d:5b8a with SMTP id
 u9-20020a0cf1c9000000b00635f48d5b8amr1940568qvl.1.1689269909260; 
 Thu, 13 Jul 2023 10:38:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEX3ugbrH+eDxrgz7i8i0JfKXrSM7JpgaGH3BOkaUScEjQUtxRDPUymhdFtJ08JgNfw+xLpxg==
X-Received: by 2002:a0c:f1c9:0:b0:635:f48d:5b8a with SMTP id
 u9-20020a0cf1c9000000b00635f48d5b8amr1940556qvl.1.1689269909043; 
 Thu, 13 Jul 2023 10:38:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a0ccc07000000b0063600a119fcsm3251259qvk.37.2023.07.13.10.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 10:38:28 -0700 (PDT)
Message-ID: <f683ceff-16af-cacf-d792-a2ee7a60f306@redhat.com>
Date: Thu, 13 Jul 2023 19:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, ard.biesheuvel@linaro.org, j@getutm.app
References: <20230713171955.149236-1-stefanb@linux.ibm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230713171955.149236-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Stefan,

On 7/13/23 19:19, Stefan Berger wrote:
> The ppi command line option for the TIS device on sysbus never worked
> and caused an immediate segfault. Remove support for it since it also
> needs support in the firmware and needs testing inside the VM.
>
> Reproducer with the ppi=on option passed:
>
> qemu-system-aarch64 \
>    -machine virt,gic-version=3 \
>    -m 4G  \
>    -nographic -no-acpi \
>    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>    -tpmdev emulator,id=tpm0,chardev=chrtpm \
>    -device tpm-tis-device,tpmdev=tpm0,ppi=on
> [...]
> Segmentation fault (core dumped)
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  hw/tpm/tpm_tis_sysbus.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 45e63efd63..6724b3d4f6 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -93,7 +93,6 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>  static Property tpm_tis_sysbus_properties[] = {
>      DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  



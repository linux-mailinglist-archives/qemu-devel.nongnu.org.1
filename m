Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD6A27A84
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Feb 2025 19:49:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNym-00051C-2e; Tue, 04 Feb 2025 13:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfNyi-000507-41
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfNyf-0001Xm-T8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738694933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cfMDgGDbXJEe0LEfpynf1Z/cTkr4nrcDHMdkC7A8pMQ=;
 b=XpoJIe97xVxO/G3KR+6IIL6vvAL+zJVq8/UTRkaZgzuMOM9kE2pU+n600KUDIu4RBSiR2u
 ZoDg9FrV1AhegmkYhJwhN/PBll6FojmrURAF+mZxC8E9FsoQettBSX0z9QcA/RQu5LThw2
 6N3ML/oFdNmeDEFU5skx/JC2lK3BNqU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-mH1-aRRDNZ2ZcadAPliHJQ-1; Tue, 04 Feb 2025 13:48:51 -0500
X-MC-Unique: mH1-aRRDNZ2ZcadAPliHJQ-1
X-Mimecast-MFC-AGG-ID: mH1-aRRDNZ2ZcadAPliHJQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab6930f94b7so623224166b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738694930; x=1739299730;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfMDgGDbXJEe0LEfpynf1Z/cTkr4nrcDHMdkC7A8pMQ=;
 b=n7H9dBFYGu2rsO52NaKBr/FFE8gXI0r95fcMy7a1D5sCVsa1G4leh4jy/FlYnfBJ97
 Uei3FgMhEzgiXF0Ms6TlL0G0PtwB9y9X2XFiiUplDJd4Iq/x21HIcqHw4m+DcwY2usVN
 8+CX5GaWOEzKktjf/4bAVwyvae8/l/H+nvM0wfLLZyXrJbjqnxG27pZgcXr8LR+LGhl2
 pNAVUtHDu4c7udT9W94p8NleR1tuhXntAB0Jxg1ONL/KHSlgYCvvX4fYJqbdvL3VR0xW
 MxaB47dPN3wqEnVQBy0o58KQxD7D0L0Y/WhQe2FCJw4zGT6cwXgD8zviwM+jV6VvxUyZ
 Ih+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkmn/Dnh1WdnixJVk6Ka+iZuH0aZf53cu3dsn3hwSlM8H2boWClLvqgB8LMXnnk+jhr2DXRXpHCSh@nongnu.org
X-Gm-Message-State: AOJu0YwJeuUqD4MRBFzNnGvOqbELV219RAb8bWDatSyEzJFXyDs3hYtD
 60U1Q4YfnWMMB30ESj9AGuBCpavfAxkuu/DKDGjaOKODn8iUwKFLEoNkyhYQtwuIxJ+oiM+QuHu
 YZem/fGeSCCaPUOLrDAN2UFTJzKpZrbA6LD7EnzkRs6j0MNr9YDzO
X-Gm-Gg: ASbGnctPIgrknkbEWt1BYx63yIXl8H5xUxTyfXo+R/pIrE5FZP5jXtIPvS4ohZnNjkg
 wjhWLIvvFtWw5GC8v2DOpwX9JL/dZACDEY2QgsD67SM2tsxpejVyhzOLYYQHy3nXynOZBB+2Bxy
 2PUy/EWlekL95ZmKlK/kNItMVSK+c6MsNJkEwoaVJoA9ZZXmFpEpKWP8cXmVN73P4fHg6w80iao
 UUUndVeyk4jEzHNb68/E6mMtZHreYGbUtK5Ss7RahzNvjJX9QLmH7gOUUrnfXG44ewuR3uDcMi8
 Vi+/jORvInXZ0YQFEEGbJoqjbpjCRHAMMp2L
X-Received: by 2002:a17:907:7e88:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-ab6cfe11e52mr3450967766b.47.1738694930346; 
 Tue, 04 Feb 2025 10:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiwN85IkZihzRabSNZOzPkk4MITGIbnzIw02AmeEsQrIhqLx7SoayV0JVcWMatpBqT9DbOhg==
X-Received: by 2002:a17:907:7e88:b0:aa5:44a8:9ae7 with SMTP id
 a640c23a62f3a-ab6cfe11e52mr3450963966b.47.1738694929913; 
 Tue, 04 Feb 2025 10:48:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a31624sm969918966b.142.2025.02.04.10.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 10:48:49 -0800 (PST)
Message-ID: <8c242279-7111-4909-8aa3-744d4d7ac610@redhat.com>
Date: Tue, 4 Feb 2025 19:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] hw/boards: Ensure machine setting
 auto_create_sdcard expose a SD Bus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20250204182903.59200-1-philmd@linaro.org>
 <20250204182903.59200-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204182903.59200-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/02/2025 19.29, Philippe Mathieu-Daudé wrote:
> Using the auto_create_sdcard feature without SD Bus is irrelevant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/vl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 5ff461ea4ca..dd8053e1e79 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -53,6 +53,7 @@
>   #include "hw/usb.h"
>   #include "hw/isa/isa.h"
>   #include "hw/scsi/scsi.h"
> +#include "hw/sd/sd.h"
>   #include "hw/display/vga.h"
>   #include "hw/firmware/smbios.h"
>   #include "hw/acpi/acpi.h"
> @@ -2661,12 +2662,19 @@ static void qemu_init_displays(void)
>   
>   static void qemu_init_board(void)
>   {
> +    MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
> +
>       /* process plugin before CPUs are created, but once -smp has been parsed */
>       qemu_plugin_load_list(&plugin_list, &error_fatal);
>   
>       /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
>       machine_run_board_init(current_machine, mem_path, &error_fatal);
>   
> +    if (machine_class->auto_create_sdcard) {
> +        /* Ensure there is a SD bus available to create SD card on */
> +        assert(object_resolve_path_type("", TYPE_SD_BUS, NULL));
> +    }
> +
>       drive_check_orphaned();
>   
>       realtime_init();

Reviewed-by: Thomas Huth <thuth@redhat.com>



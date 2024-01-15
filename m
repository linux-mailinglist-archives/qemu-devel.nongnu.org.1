Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D696C82D8E8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 13:34:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPM9F-00021y-OB; Mon, 15 Jan 2024 07:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPM9D-0001zi-K7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 07:32:59 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPM9A-0002Qd-6A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 07:32:58 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso8443333a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705321974; x=1705926774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DA+SM8YT8bb9bH6m7D9z0Vg+SA2ASxEDsr/aRYtW9+I=;
 b=FbeZ+jQuItye86/RQi2YDaf8micyP6nZFHUIMqXadSxxwb+DYSXZruWGfJ2o65mllx
 h3DBr5S2LJsRYEjbeN3c3MzbgM1vxUOzyZ5jgJRkVWSklYeJXDdFlZP9h29KbM1BzwxQ
 MOlF9/OgOwhNhtdbXeftxiyLaia9pd88laiHQPI5S5Q6U3JmPXXBYw58hScfWe3hb6hX
 0gy1ITvKRA2xI152VnFGKQHM0tSrpQ1ELSB+nkqSG41kWtAJyZvwwQZ0ojLlku56/jUr
 0OQUYjIdAbcwP2/kGrn9o0tcdzaHvQXVWuVv0HiATdK0lpjE5C3Nr4vfhcBimMta1esh
 9hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705321974; x=1705926774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DA+SM8YT8bb9bH6m7D9z0Vg+SA2ASxEDsr/aRYtW9+I=;
 b=kLogIZQB2kXtI4kXhmx8G5pcqQ0hNWiq5IHIGhgHUl85fs/1ZHF3yP+tS34OvAULkm
 2DxpreWs6xDXNANtfey8iHFljNWUHtmdPvgSy34+WKdVLFuIpgyd9ebgpzYiQNA2fKKh
 56o3dPY+E0EkRvgBXwCLgFOn7PUm1t5U4IFO7z83oTv/eIzAMI18sHLVLW2PvXd/89Lc
 la+hChY9DSvuRLpWNDjXLsmJXwrwhMflJsj6GnQIhWg4srXQMrwO3efaEj+SH+yxRjaO
 PpSk2qHKWQQqLIiMk9Jq9ps4ZIS0MjhtHzhViAO3n3jNZU0ETjoOHu7iuAgRnQWMy5+W
 k4IQ==
X-Gm-Message-State: AOJu0YwjQoVF2DOexfJwsNJ21mMYT/qT2N6VzwFKPNJp+5dJJ1brqwlY
 m0OSaAZlifvyhpVhPn2OxqmcMqIJwFIam9IcXAW+Klf3PPFnmQ==
X-Google-Smtp-Source: AGHT+IEwgLUtUPZS4DuPbUkCaUPJfcfzTji5UT4WiPKVbwL/ZG8fp+2QRSCc6hPqR+EL2aqVRpavjPp1ueDVp+57hts=
X-Received: by 2002:aa7:cf19:0:b0:558:f01f:6845 with SMTP id
 a25-20020aa7cf19000000b00558f01f6845mr935066edy.168.1705321973893; Mon, 15
 Jan 2024 04:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-12-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-12-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 12:32:42 +0000
Message-ID: <CAFEAcA-+eoyY2_+21ybA+Q-bkbTooSfdf+Ooti8SG-kHR5osCg@mail.gmail.com>
Subject: Re: [PATCH v4 11/45] Introduce Raspberry PI 4 machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

> @@ -329,11 +330,24 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> -    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
> -                                  ram_size - vcram_size, errp)) {
> +    vcram_base = object_property_get_uint(OBJECT(s), "vcram-base", &err);
> +    if (err) {
> +        error_propagate(errp, err);
>          return;
>      }
>
> +    if (vcram_base == 0) {
> +        vcram_base = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
> +            - vcram_size;
> +    } else {
> +        if (vcram_base + vcram_size > UPPER_RAM_BASE) {
> +            vcram_base = UPPER_RAM_BASE - vcram_size;
> +        }
> +    }

I think this might be slightly clearer written as:

   if (vcram_base == 0) {
       vcram_base = ram_size - vcram_size;
   }
   vcram_base = MIN(vcram_base, UPPER_RAM_BASE - vcram_size);

> +    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base", vcram_base,
> +                                  errp)) {
> +        return;
> +    }
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
>          return;
>      }

> @@ -293,11 +292,20 @@ static void raspi_base_machine_init(MachineState *machine,
>
>      vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
>                                            &error_abort);
> +    vcram_base = object_property_get_uint(OBJECT(soc), "vcram-base",
> +                                          &error_abort);
> +    if (!vcram_base) {
> +        boot_ram_size = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
> +            - vcram_size;
> +    } else {
> +        boot_ram_size = (vcram_base + vcram_size > UPPER_RAM_BASE ?
> +                                UPPER_RAM_BASE - vcram_size : vcram_base);
> +    }

This also could be written

    if (vcram_base == 0) {
        vcram_base = ram_size - vcram_size;
    }
    vcram_base = MIN(vcram_base, UPPER_RAM_BASE - vcram_size);
    boot_ram_size = vcram_base;

>      setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
> -               machine->ram_size - vcram_size);
> +               boot_ram_size);
> }


> +struct Raspi4bMachineState {
> +    /*< private >*/
> +    RaspiBaseMachineState parent_obj;
> +    /*< public >*/
> +    BCM2838State soc;
> +};

Our coding style no longer requires the 'private' and 'public'
marker comments, so you can drop them.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


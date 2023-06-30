Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA3743D87
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:32:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFF9V-0004RS-Af; Fri, 30 Jun 2023 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFF9O-0004RB-Ss
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:31:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFF9M-0000OI-2W
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:31:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc0981743so17907795e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688135462; x=1690727462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vggJ6tb3SSnV3/liiWzvtu8opHNbtqX7WLrmXfkgQ3o=;
 b=SAfuGMRRAVJ+JStP1pe1ROHs7ykyqZFMfUNKRv/00/7fvKxxkphsto+BlH1AeY9hzO
 kt1a/+3XSnyoDU2PuVMHt84W96POcdkHmpD+m0LGAdwt+nHt/7Kbx9aQCXpIWPh+oxj9
 HP+VNUWUqAyr2Mw/LQ4wx6LPnWRv+JnJW/cWl1oqL+LZmgkTRV7sRRAgrPe2vwTxjKf2
 rS2oC9c87e3cjDXgzcQ+UCIL4IyqxepHerfboh4IWqAteHvpgJ8cB8t0QAR0wEDXVQWx
 M7Asc0ag5EqsHA+INxXLrip5XoM4/epl5W3zU2tCTP4wFWd30gvElqOdhNbYxmOEuFLg
 tskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688135462; x=1690727462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vggJ6tb3SSnV3/liiWzvtu8opHNbtqX7WLrmXfkgQ3o=;
 b=lOydkenX53ji1JQk+Av8bax9Ej5/ZR2tyC0/VCpw5M5/jdZU29hK7KlotmFGVbxGK6
 JFD7s+bjEUvh8LBSHa+nBOc+G0vu9jVoy5Z/fRsIn8zkUZ4uxhLzlbfNdZ9DgHG9NJ2h
 8VZWQJJcsxIrbn7TMv/qpTp4Ej226VIOZSrWeo8TEFDH7+pLDsoVV3x9Dqa+LTNXq4OF
 ymk1343TQxsyAuaVCofO2QDiK4T0JI0c7gba+Maw9mAoUNlzRXLAEi/F7y6VDxOcoMJX
 iWJafFfbGiKPlCSjvSU1s3rH6qO491OiggRKdo/6M9YTBKbcYt9AWbFMNP3vg3BSByR2
 li1w==
X-Gm-Message-State: AC+VfDwgNNVx/ydKMBQFX2NzC/id60t2dvMgNzN12p8sdCzhOb50qMO3
 wUsFcO5ZVB/lwfu6trHwbozNR+/lt4KOxnkemxtE3Q==
X-Google-Smtp-Source: ACHHUZ6fKDGQdZ+buAcPpAr06Zxq95L4X0y3UReas148tPGLbYEs/C1nwp4kzW5Xy69AZtPFpI2EeQ==
X-Received: by 2002:a05:600c:2484:b0:3f9:b79d:a5fa with SMTP id
 4-20020a05600c248400b003f9b79da5famr2128859wms.16.1688135462299; 
 Fri, 30 Jun 2023 07:31:02 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f90ab2fff9sm19048305wmi.9.2023.06.30.07.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 07:31:02 -0700 (PDT)
Message-ID: <66b37cc9-4f48-3ba5-8f3e-39f7e715970e@linaro.org>
Date: Fri, 30 Jun 2023 16:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Unused variables in dbus_call_update_gl
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <156d2af2-5e64-39f1-fdbd-54f6c299515a@eik.bme.hu>
 <336f7697-bcfa-1f5f-e411-6859815aa26c@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <336f7697-bcfa-1f5f-e411-6859815aa26c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/29/23 15:15, BALATON Zoltan wrote:
> On Thu, 29 Jun 2023, BALATON Zoltan wrote:
>> Hello,
>>
>> After recent commits I'm now getting:
>>
>> ../ui/dbus-listener.c: In function ‘dbus_call_update_gl’:
>> ../ui/dbus-listener.c:210:26: error: unused variable ‘ddl’
>> [-Werror=unused-variable]
>>   210 |     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener,
>> dcl);
>>       |                          ^~~
>> At top level:
>> ../ui/dbus-listener.c:180:13: error: ‘dbus_update_gl_cb’ defined but not used
>> [-Werror=unused-function]
>>   180 | static void dbus_update_gl_cb(GObject *source_object,
>>       |             ^~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> when compiling on Linux with gcc.
> 
> The patch below seems to fix compilation for me but not sure what else
> would it break.
> 
> Regards,
> BALATON Zoltan
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index e10162b279..601c134e09 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -177,6 +177,7 @@ fail:
>   }
>   #endif /* WIN32 */
> 
> +#if defined (CONFIG_GBM) || defined (WIN32)
>   static void dbus_update_gl_cb(GObject *source_object,
>                                 GAsyncResult *res,
>                                 gpointer user_data)
> @@ -203,12 +204,14 @@ static void dbus_update_gl_cb(GObject *source_object,
>       graphic_hw_gl_block(ddl->dcl.con, false);
>       g_object_unref(ddl);
>   }
> +#endif
> 
>   static void dbus_call_update_gl(DisplayChangeListener *dcl,
>                                   int x, int y, int w, int h)
>   {
> +#if defined (CONFIG_GBM) || defined (WIN32)
>       DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
> -
> +#endif
>       trace_dbus_update_gl(x, y, w, h);
> 
>       glFlush();

I'm going to commit this later today unless Marc can immediately suggest something better, 
to un-break the tree.  I really should have done more thorough testing earlier, and not 
allowed the merge to proceed...  Ho hum.


r~


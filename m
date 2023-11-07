Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FB17E374C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:14:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0I9M-00079d-JX; Tue, 07 Nov 2023 04:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0I9F-00079I-43
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:13:25 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0I9C-0007Y6-O5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:13:24 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so3433753f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699348401; x=1699953201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLRA8CpsoXh/E0fBox6b0adU8hjdhjG62biOAb1HQpk=;
 b=wcpEQ5ZrS/Wnqs/IG0mznRJmuX8P6tspVxzbv0FWvFA+8FUsKGn0Atg9KiiqSAiPjD
 4YzcMA8zybQuLgDyCt3SWbvPkeDWRpcHNXbrP7j6scKEVCLrtbl5xtkAegc8KoKYmk65
 8yr7rg3FCr90JIgi5r2KMgF26EwXCNC85jqRdDaM2AseKMRXS92Dx2yp0JTyK8uLffuq
 R+QPTKW4thoSTXudsxJ/iq3r7JxkEnNIpvmusgWXurG/rmNUlGxEkVBoTEpsCE/lVTga
 +K3/2EfMe4JvEtwonKbmuZ352hcpz3MraRHcpGCvZ6tvcQ0bHf/QRGOtBYSWF0WbfQRc
 +wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699348401; x=1699953201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLRA8CpsoXh/E0fBox6b0adU8hjdhjG62biOAb1HQpk=;
 b=ms/XPH2daJQ/czhKXJi7oWaAmrz3+dQ8ve2l/64FZhjOCV7J2otbrsUyOa0bfhy2nU
 CO3Mns2ksI0KnzRxi2xkieCCQcnjq/jGcm0T6ADxIfXbP106AW/1rqsoPFH//5BfJQhE
 1325o+Mq41fsTLDPSigAYfGSegIoin3g4JK2ZQXmT7tz6+2TiO2+By9bpHCNh+VNSZ5F
 KFlyYw3kKy+NBpsdWi/pscwiYUAnjYrFWRiHiu8V0cZnVQbHNm/Vjg50YzYzeAZRKBeO
 a7DcXI3G7+BrUfTeFUWVkMzXDU8xXg/gZaSkuzcr6NAt3hCbnvb2d+eJEeBfoRpKafdU
 xwiA==
X-Gm-Message-State: AOJu0Yzq5H/nd0ibBXjhOLxbILatxGMR+zZHnubBFNOfsHhw2VJNxlVY
 7Np/yp89vJYuHtDgxiJtvVYsKg==
X-Google-Smtp-Source: AGHT+IHujMvEzXNR/UYRw+wkjvSu7Q4dpAXcV3xWYRluGgzXRiySmfoR6sbMC1BOQzzzloWj1uotzg==
X-Received: by 2002:a05:6000:402a:b0:32d:89ca:1761 with SMTP id
 cp42-20020a056000402a00b0032d89ca1761mr28005981wrb.43.1699348400949; 
 Tue, 07 Nov 2023 01:13:20 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a5d5688000000b0032d9382e6e0sm1781375wrv.45.2023.11.07.01.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:13:20 -0800 (PST)
Message-ID: <a827a40b-0c54-4f31-9631-957247e712e7@linaro.org>
Date: Tue, 7 Nov 2023 10:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/24] ui: compile out some qemu-pixman functions when
 !PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, stefanha@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107071915.2459115-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 7/11/23 08:18, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Those functions require the PIXMAN library.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/ui/qemu-pixman.h | 7 +++++--
>   ui/qemu-pixman.c         | 6 ++++++
>   2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



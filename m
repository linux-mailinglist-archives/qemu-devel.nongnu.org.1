Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536C828EE9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:34:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJiy-0007fU-Ut; Tue, 09 Jan 2024 16:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJiv-0007fD-N3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:33:25 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNJit-0004OM-Sg
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:33:25 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6ddeb7b4366so407853a34.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704836002; x=1705440802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oNbOEDHJn/VRYAoKZg2JXvPMgzLrLAYiKfGuGTnH6FU=;
 b=ZrlvwETkvOQ/bjGsUI/jqLC7XkPfEtcisGiY2vLIia96+nRpJLXo1AsKr+GaYfjqNN
 m7WuPkY46cX0Ry32LbJh6YG1wmmtGAWG4xFnwXYazf5Vz5ULT/xsCuq4z4R0RX4fysjQ
 N7SN1XNEXipnsSOIe5Wwks+j2Yr2CDUropmbAHfhpJcJ3KMS0UXYtF8wdqJsXXqsF0RT
 iKnn7tI/ym8oPC971lV3+rNCVkPZSqN29z05fedPuk/QK5QV/7BhgoyJ2+yd6ZHMNvBF
 TPsQWO2UdKpZxozLblXsdL7sNmPHeBlRuupn59vT2r25JMke8xuLh4i9ny5J3eifFOyn
 grBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704836002; x=1705440802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNbOEDHJn/VRYAoKZg2JXvPMgzLrLAYiKfGuGTnH6FU=;
 b=G7ZX2Mc6N77ZOLes3tx9/bAyQaAos5jyTZfhjq4aUJmWDxRaclbFYOHdXcbdJPC2yN
 jEuyReIcM7y93oT+P03cQiFqAc2kb6tulQGYwUQaHbcT1V43POuOE5kxEPWnG2Zh9uO/
 8dUHkW+PB2YfJ8g+jbdTTkwHJHjR9n0sC1Msmp7ntTGQMbkSjgp6hZIWUFkE/65dgNAW
 fUdRXfedA2itWHRYhYt4EDSW2dsKFSx6++yA1bMhk2XyUToEGIPdtIvLtPeanXN2qaGm
 M6MnnBP72X1FQ5dcDj0gbi9EdN0jMAELS9mZanHn3BTfabEQLIqB+Fr3H0ij5ctDkXoa
 vhIw==
X-Gm-Message-State: AOJu0YxdlFDwFo3LkydTwZLpN0YYyGbVopNCeS8n5oLMrKWnUIYr43an
 t6twQQbxZDRz25gN+pQg+XzCR9otTHk/QLQYgVXmytHwdxG21g==
X-Google-Smtp-Source: AGHT+IGQjfjr8RBGShQo+wTrQRMWSEXkFjUk4adla/efi/iofo5MKej8x7BO4hHOHJT3cfdhHlsX5g==
X-Received: by 2002:a05:6830:1645:b0:6db:bcb5:7ed8 with SMTP id
 h5-20020a056830164500b006dbbcb57ed8mr9389otr.1.1704836001930; 
 Tue, 09 Jan 2024 13:33:21 -0800 (PST)
Received: from [192.168.44.231] ([172.58.109.85])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a9d6401000000b006dbcd704e8asm517193otl.45.2024.01.09.13.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:33:21 -0800 (PST)
Message-ID: <26f604c1-f3e6-4ae8-a502-a7b92c1c1d30@linaro.org>
Date: Wed, 10 Jan 2024 08:33:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] linux-user: two fixes to coredump generation
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20240107-qemu-user-dumpable-v2-0-54e3bcfc00c9@t-8ch.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240107-qemu-user-dumpable-v2-0-54e3bcfc00c9@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/8/24 01:01, Thomas Weißschuh wrote:
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
> Changes in v2:
> - Rebase on 8.2 master
> - Resend after closed tree and holidays
> - Link to v1: https://lore.kernel.org/r/20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de
> 
> ---
> Thomas Weißschuh (2):
>        linux-user/elfload: test return value of getrlimit
>        linux-user/elfload: check PR_GET_DUMPABLE before creating coredump
> 
>   linux-user/elfload.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> ---
> base-commit: 0c1eccd368af8805ec0fb11e6cf25d0684d37328
> change-id: 20231115-qemu-user-dumpable-d499c0396103
> 
> Best regards,

Both patches look good for correctness, but both have style issues: need braces on those 
if statements.

With that fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


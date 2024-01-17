Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D0830998
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:20:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7hK-0006w4-Bu; Wed, 17 Jan 2024 10:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7hH-0006v6-VM
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:19:20 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7hF-0006rw-Uz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:19:19 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e67e37661so15452397e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504756; x=1706109556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HHYmLGfhuhfWyv2kFg/CkDEyBQ4xctMKT4Xu3SyO6J8=;
 b=qfUvI/rxgmjYDm4Xz8b+ImV/Tkn/V7HSsdrQaPSCqiH8d1t5q2j5Xk5GRjA5Z+xO4X
 ZTeVhXPCvM3z6eJDww/eNf1Ast7J3InTnzlMH8RzHQkG5XbqRauz0WTdb/xzrW+KRG1O
 qXXHibudaT+aCPCuTekKFXMa+CfykFQ6XUkbYKT1hiXCth1DbWqOzwBLb7uFNlBAxjZL
 Iq7YTAKhVVS6dfOvjxB4Xuhm8OfSCn3rjLWFp/JvFYJBcuMpNUgzkSsZhny2Sr9yN92H
 98W9BLbkRmFmAnU7na31d/DohRflGtSXlcJc6qpJzL53m+t2mkJUq+19vxgB7IzN55rD
 Mxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504756; x=1706109556;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHYmLGfhuhfWyv2kFg/CkDEyBQ4xctMKT4Xu3SyO6J8=;
 b=wt6sx7pCtRfNoq0iDJ0ZD5brc2rz3hiJJNOuVphbU7h78ub6V0Z8lg0L+Mq7ULeByM
 iWmJ0Mj/HdgtwGvG/57g4RTTleFANWylNaMLAcHq/1BrxU6YclFCQM810OwqR1HpCA11
 ROjv8roz71ztT3V6VGh/8ebPQtOUNMl/NzNzB8dyk97fHHEFRAxIQ+6Fz0F53M61CqkN
 EUWyOq6hMksRDYCHPq9WylRRIBQfFRvapb6HWaRzZGDyBZNW7hLPjCxqiA1eGhyB7Yj5
 18ONJK/EXHMVtiMZnAlimQIixn+iL895vENYRlsQAPCtMB5Za6rMxVLBYN1uln03w2jb
 5alg==
X-Gm-Message-State: AOJu0Yy0967Q1JkKh5DejVxoY+bK7iXwBhbfSmx2WMtwQJL6fPUaCDbC
 op3jR1DAYBpolzUp6AweV6ypq0CFxsCOkA==
X-Google-Smtp-Source: AGHT+IEFvct7q9gi45Qabayk/rQuAC21/JYMX2fdyztnkZb3mL2DKWFM+ERuHAf1EXALUuHuceDBNg==
X-Received: by 2002:a05:6512:10d5:b0:50e:aa1c:3241 with SMTP id
 k21-20020a05651210d500b0050eaa1c3241mr6054806lfg.19.1705504755923; 
 Wed, 17 Jan 2024 07:19:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a170906381200b00a2699a54888sm7857158ejc.64.2024.01.17.07.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 07:19:15 -0800 (PST)
Message-ID: <c1ad2d9d-9dc2-4825-a7a5-8be69255d981@linaro.org>
Date: Wed, 17 Jan 2024 16:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs/about: Deprecate the old "power5+" and
 "power7+" CPU names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240117141054.73841-1-thuth@redhat.com>
 <20240117141054.73841-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117141054.73841-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 17/1/24 15:10, Thomas Huth wrote:
> For consistency we should drop the names with a "+" in it in the
> long run.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




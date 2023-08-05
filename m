Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B462770DB7
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 06:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS8oK-0007Z9-GM; Sat, 05 Aug 2023 00:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS8oI-0007Yb-QC
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 00:22:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS8oH-0006lp-7m
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 00:22:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso19105545ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691209355; x=1691814155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+VRzxQeEl5mDh89wqIaZzgZQ5DegOjRNS3rMeHOVqo=;
 b=fl4xaVpgD6GXEvpTsQJJASXC5yS2XuCdPtlv9jIPsCHXxPHTfxCQhq9EmYQ5WYLsam
 hWnpgqRfkHCjqUaegLzLjRAIRap2DuPraFqkGEBzA0jE/yWlBWm1x7VHurA8TgQHjqON
 dptjBunOq+cMzs8NMbavytLdlMgK3vGa/zqBlNzQUYBKyJWSSJ1/KeUEbBK+9wj6OYf+
 GFn75xvATnvzXmZQNzLzX0p7k9z5VNYd0IK5C045KTTNzxcYUYRKv+46LCJs4qsk1655
 0cs0ROFVR5AdNm9aof/iR/YbMUF4ASjd4ChzlyTbqSE+Tcrd7vQMAel49QoQ9YvOnqhT
 aE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691209355; x=1691814155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+VRzxQeEl5mDh89wqIaZzgZQ5DegOjRNS3rMeHOVqo=;
 b=Wv8CmRhy3/NA+uCHiupv0RWD3en4SKc47W+tS2z6riVvY0bOo9ogkUq/epj319jIRZ
 bN2S3Eb8UkNGq8oAPw6GB9chkFDMQugiZrkiN49dqTB1J6VokmFdy1MGXFSfxGjoBnwj
 c7E3LMX/uytzKNDOl17R7ODZTlAXP5Oo48fWE8fuSBxehTrGmADIVCOZZMCuMb5i0w+y
 +Av2dloJl1GhySrcpB48rhf1omE18arSNhjDXPF/w8KddbOs40S7PpZHICc2uOO6I/Ru
 RX96znYKSbwBB0Q2hjvz6m78fuQS3vZHYDbvSWxy7pHjAN0a2prvAVpTdGc8D/hlC3qE
 lXcg==
X-Gm-Message-State: AOJu0Yw+lmIPdW+l52IJ+0erGwhvi4S1mKwh/gLJIQPYPKTpy2GC2B45
 L7MhDs3esH/P4w9qQ+ChKdX3pw==
X-Google-Smtp-Source: AGHT+IEFe6+aUyYY2CNUj5upVMk+hw+qzAve65isOuGS/kYrhOjmc4wUl7AEH7UbFgDlsCFJUYMSrQ==
X-Received: by 2002:a17:902:8c88:b0:1b8:6cab:db7f with SMTP id
 t8-20020a1709028c8800b001b86cabdb7fmr3221178plo.53.1691209355541; 
 Fri, 04 Aug 2023 21:22:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:c240:d44e:cb93:acbb?
 ([2602:47:d490:6901:c240:d44e:cb93:acbb])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a17090301cb00b001b9df8f2907sm2499815plh.264.2023.08.04.21.22.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 21:22:35 -0700 (PDT)
Message-ID: <d89a4106-f03e-75af-e502-75cd77a21303@linaro.org>
Date: Fri, 4 Aug 2023 21:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] linux-user/elfload: Enable vxe2 on s390x
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230804233748.218935-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/4/23 16:03, Ilya Leoshkevich wrote:
> The vxe2 hwcap is not set for programs running in linux-user, but is
> set by a Linux kernel running in softmmu. Add it to the former.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


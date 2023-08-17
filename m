Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD077F2A2
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYrl-0004gK-V4; Thu, 17 Aug 2023 05:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYrk-0004gB-7W
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:00:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYrg-0003Ki-Lf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:00:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9923833737eso987505466b.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692262822; x=1692867622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EEFnWqkFWLw55LfuqTiNueznp0g2ZpSvi5r61lGpn9w=;
 b=ZjzKXkJ75FsBZRVOFBlrr1ha9nwLzZI7+AvHOUW7He9cpzX0EfpPuKg9+wHzWB5Pou
 ta6TC2j1L8cgeMLAvU7GKT2VrTqhm+ve9h9vZ/MX3pPiMj4IkwNSRxrLHrZa+/bCedtu
 5njArUcRFtKKIyphrtFR07jbzwJwUJrW0a2VmFlfbEc4w7qx7AwNGDqyj5q3//jyPKiE
 haFQrTXHDBrHUODIeWFjH9LSGHnK3amhZvfhaLvyIcMQsyY5LqaG5yQcbNPKIYy1Wf1n
 jePQFo8C4NOPs42DJ0ePmALe2pl5MwQwzkDczvrP+ABPBtjyNlbdpkEzgDz6EB9L1QWg
 1rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692262822; x=1692867622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EEFnWqkFWLw55LfuqTiNueznp0g2ZpSvi5r61lGpn9w=;
 b=IrG2Gh0/lNW6Un+iyv2b9KpcLbxRUhJAzFaFGDhbLDE7xPtSr66FqGRxXU05lVBeNF
 z26OopMUwDpX3Dq0JukmEMAgnl8zhAzQD9KCct7LbIGIMLQwi+ZmFTvS4Mpzbx8ezKQw
 xcaKuElzkTWrsyVN7A2vwE1dSi2PJZxVZnCVdN3RM3j4hhOnHud8/82bWD+5W0nVFG0o
 /m6MRdB/Y4gIjvHczAp1j6gki1bxV5RRYYXhlwk0B+RcOH1klomPI870CHYyqd23odGt
 PAT5yJSXtc14j3iSj/mczucZSeL8OG/PTJu7hXQpnlIMYTa30UqaPpunlq1bxqBwtN9O
 xC8A==
X-Gm-Message-State: AOJu0YxNCPkkFPAIGtrGmuqqQ9pDuHxJeVRTuznHjwNcdGmEjdzYmgIj
 va2v0gXOsxLkLfsGLXISVMZ/noxF06z61CvIc/A=
X-Google-Smtp-Source: AGHT+IGGyhbSdjT09pfxvVGSLOPqjOxxvxi35xOfErLtGJK5CyS9NBg8NIufrp5xHaanKEKs1mDK8A==
X-Received: by 2002:a17:906:30c1:b0:98e:16b7:e038 with SMTP id
 b1-20020a17090630c100b0098e16b7e038mr3873512ejb.23.1692262822067; 
 Thu, 17 Aug 2023 02:00:22 -0700 (PDT)
Received: from [192.168.69.115] (mek33-h02-176-184-23-56.dsl.sta.abo.bbox.fr.
 [176.184.23.56]) by smtp.gmail.com with ESMTPSA id
 y12-20020a17090629cc00b0099bccb03eadsm9802906eje.205.2023.08.17.02.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 02:00:21 -0700 (PDT)
Message-ID: <3b8a822c-cdf7-bdae-4cb4-5c66d93479d5@linaro.org>
Date: Thu, 17 Aug 2023 11:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816181437.572997-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/8/23 20:14, Richard Henderson wrote:
> The start_mmap value is write-only.
> Remove the field and the defines that populated it.
> Logically, this has been replaced by task_unmapped_base.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/qemu.h    |  1 -
>   linux-user/elfload.c | 38 --------------------------------------
>   2 files changed, 39 deletions(-)

Can we squash similar removal in bsd-user?
Either that or in a different patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



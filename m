Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D305792D69
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 20:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdaqj-0006UK-HP; Tue, 05 Sep 2023 14:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdaqh-0006Tl-No
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 14:32:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdaqb-0000q4-VZ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 14:32:27 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c8a710545so2670758f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693938740; x=1694543540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85oPw/o+jfreSnMK78fVRu2bd4BPVM7WW5z1p9Do4D0=;
 b=GZ8Slf2XfqYHcaSz988iRPN2Npb0F6Xu/t8bVbIVgK2QLeR4YkPBuISFGxlRMjGJKT
 IONG0KT4T0CtxZ08IJSTSGmkYilvV69NOyRpB4jGHbSdfz9dXLTPr+UJwWWbbOOkc9NP
 /OdcbP1DWokIlm15Hewn1gVlwXQ/o005Xp9lGkwark9O+y0VdMfPAJ3xu65oiOEBOgAf
 ra4XkiM7b/QksPxHonRcytWFiwrPxiQLaQ7c6IvGMkyvecQPJIr8ALFFbmSeqSoeEYz/
 +aSOf4BGcJ4H6HSwiJ2kj7/afyoA0e0IQXv9jcvEZL+K1rOejGQ3WRNdEb/bO4sreZkK
 tPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693938740; x=1694543540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85oPw/o+jfreSnMK78fVRu2bd4BPVM7WW5z1p9Do4D0=;
 b=NdkkUlXBnJSr+fKmuwEmBeN0gJpu66JT21OoEnymkQEwmjBhJlnJvW6JWxM59PEOhR
 w6eNBRBBGiNk0Gvt4m9TtVggpBmVKB2cpwJzC0K38fjz2IUbCohglCpMkhwE+01YV00P
 cpHw0k+dOdPyOxrKNagIasHFG9IVyLAq41ZEli9A6PQpnkPdLeo+8zqdU2sbP4HtjUsK
 fl0Xstv3tnmunlaV/JkLaqy6Bhs1rguy952GAtboVtnXeiXbPydl1nWILe8GAF68Xyc9
 TmKRBWg9Qpcsb5oMEGsfvPPyAALyHu38XTRYwbrNbGvQJ+FZZ7z/T3pLzoV8an6yhq67
 5Zfg==
X-Gm-Message-State: AOJu0Yzw7DDBoZhGaxKHEKTRi40T1gJNHMdFkRGEcSS+CwIlQrXibl0d
 a4Ww1dbcqlg80F7PeEbYn0eQVg==
X-Google-Smtp-Source: AGHT+IEqF8CXtNNKqTXQDlE293yCidl/sVebSnTSuwa4kxXtoqqn8wvlPfQm6MaDbOOUE15VdssCww==
X-Received: by 2002:a5d:6a8f:0:b0:319:84b3:70e6 with SMTP id
 s15-20020a5d6a8f000000b0031984b370e6mr517514wru.48.1693938739989; 
 Tue, 05 Sep 2023 11:32:19 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 o4-20020a5d6844000000b003197b85bad2sm18239897wrw.79.2023.09.05.11.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 11:32:19 -0700 (PDT)
Message-ID: <c6dd6871-e4aa-2418-d3d3-e5cb03fdb1c2@linaro.org>
Date: Tue, 5 Sep 2023 20:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3] iothread: Set the GSource "name" field
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230905180359.14083-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905180359.14083-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 5/9/23 20:03, Fabiano Rosas wrote:
> Having a name in the source helps with debugging core dumps when one
> might not have access to TLS data to cross-reference AioContexts with
> their addresses.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> v3:
> used const
> v2:
> used g_autofree where appropriate
> ---
>   iothread.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



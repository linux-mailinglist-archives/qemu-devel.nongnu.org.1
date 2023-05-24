Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92670F81D
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oyw-0000aW-N4; Wed, 24 May 2023 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1oyu-0000Yg-0x
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:56:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1oys-00078I-32
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:56:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso11700275e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684936604; x=1687528604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G06u1uXvgp2pbGhuuLT0ZE49azJQkIpZ/Jtp+y5ITBY=;
 b=JqaXKzF4lY0gFqEPLsJZZtZeNg+rufCjUKqqfS+mQbllwIMe2omOXsO+dFtDquX14b
 bwesBeNkMA01dxE+TWcrH4ueFfGpgKMXiC5EF8LJj6QV2AG4HTgxudKYUSWQU1CSHw7c
 0wnQUmaHAjxQfYoBQv+S2YSt6B/TwunGUpwpwFd6bmYc8WjYPiUeDIMK7ohQ6/0CrMwW
 UfwbuLw/OB3CQDio7an9a9ZxjvLp1Q+BphxBxnty03mCmDIroHAX9Hw4+SW6+hHqx1Dc
 131E38OezzbVm+LiKwMyTK9bjqm9j8PCbPfvvTdY7WJgLNOCBPggoZapZMBxyqe1f14Z
 Ydjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684936604; x=1687528604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G06u1uXvgp2pbGhuuLT0ZE49azJQkIpZ/Jtp+y5ITBY=;
 b=TrCJmKHd6ZZ7QPw3VmVw6+HYmZWPj/BrNoeKaM/KcdZK+EBI0Qq7ohTkOTjComu1rK
 BFlAj5lVFnlxc0xHc3si3AUkRX9YEuqaVZogqYxts416zTZnDA5d1hdbjK6ToEZJlZMD
 mLmafaac+Xk+t6AxPltCnjtaUHaa8sW822XtuRgVvI1s5fuTFL/BfQOnp83yXy5b+k8B
 c/gdybRBzg4bh6eJKINz5iBTc8irTPNvfb7xsJILo7i63zZbrI1KuVi+u73ICXkBDEGA
 ky6W+hNyQJdjRRz4+Za8Itcn7UFQJgBbNYJvgUkVdqvTZcuByd1mmGOeG//xO9tEYzu8
 OMxg==
X-Gm-Message-State: AC+VfDx1FeQgdDgdwe6YHt3W4jwy+dW+rczbmvKnZMtDH+svldssEaOJ
 /2ghoFz7w34/HbzIHfq4JumaVg==
X-Google-Smtp-Source: ACHHUZ6TsTUA0CFICb/kQ3ywLZy5cHZ03CIt8EeAdDpxl1BkZ7TchnBJoHWeYZ0oCqdRTNqVzxNrtQ==
X-Received: by 2002:a7b:ca47:0:b0:3f6:11e9:de8e with SMTP id
 m7-20020a7bca47000000b003f611e9de8emr2037691wml.4.1684936604517; 
 Wed, 24 May 2023 06:56:44 -0700 (PDT)
Received: from [192.168.69.115] (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr.
 [176.184.31.193]) by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003f6041f5a6csm2475819wmq.12.2023.05.24.06.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 06:56:44 -0700 (PDT)
Message-ID: <64d0bf03-508d-9655-cf2e-6041a179a48e@linaro.org>
Date: Wed, 24 May 2023 15:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] scripts/qapi: document the tool that generated
 the file
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524133952.3971948-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 15:39, Alex Bennée wrote:
> This makes it a little easier for developers to find where things
> where being generated.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230523125000.3674739-5-alex.bennee@linaro.org>
> ---
>   scripts/qapi/gen.py | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



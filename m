Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985F76F9C8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 08:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRntC-0004aE-EG; Fri, 04 Aug 2023 02:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnt8-0004YU-W1
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:02:15 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnt7-0006jr-CG
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 02:02:14 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-56401f1da3dso957392a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 23:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691128932; x=1691733732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=grAl/2+rGv4JhLYFCkX3Ok/PeOsnR9MLlbtgtdVuVSY=;
 b=1cZxwdZgJfucBVxd5QekwyWotLkcd/yBTlYbbv5GkVkV1z+z7nsbTk8QeE8sNE2VVz
 jeMDRQ0tjGklxq6r4FbX4DpM+bD1D0rWcJAMkG94yV/0LkevefnOwvAgxNK4SYH9LwGH
 KfAYouXkAnz+ANJ/dzkAVle2ng/8j8iztCiVW9niUE1ROnk3pD2ebbhhz4wbm+FrKFUC
 oeF2h+W49XuHCO0dawACplv9dta0q0KkxtKIfDnihd69xoMTwQcI/FgRHsxO3LBx18ls
 Nk6rpQ1YRMG+CA9AVEEJPy8kxhC60R83yEx7oz2VY/1OVsN/L8UN1frYmdvNap3Zv+BS
 a2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691128932; x=1691733732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=grAl/2+rGv4JhLYFCkX3Ok/PeOsnR9MLlbtgtdVuVSY=;
 b=H8OefgvNQ4h7+6p1dMVexeBwji5XoQY668jMtADNp3AvC8rXNWTBxamSjSYEn2H02J
 hDgy/fq/L44WZc1/6zUsUlbGMtoeOH+IheoSErzzVp+6+nNoEV4cJgD46AdHnY3CSS7I
 jMEn16hfHVQrBszA5olu08YLnxCz1+JOU8w+8SSr6R4Q9g10exQ7kY4owV29nfsHCQof
 u8Ap1UR1wGdp4yg0t9Y/h48MDMKRv/bPofcfvkQGy6U0qQA4wQFWELnlXgBdgVtV4efg
 9xoBjfjBeOA0TAC27PC+We3n3+9OXz0oUB36TeIMGMqWpfTrtD1eez8wACrxBbPLMvUq
 7BJg==
X-Gm-Message-State: AOJu0Yz3xbzi7Ld81PcmYpQ7MgAuY0gHWSgalNJs/wdhZ+N4cdCObZEl
 0sbI6tfLQNQCIPjxg4ig6PQ3fA==
X-Google-Smtp-Source: AGHT+IFDi3ZmgHmsb2dK4i1DrlH3nyUkIm3L60vpVkw69jCI8InqSz4AEtuGDosPs/3xhz1CBkLsXw==
X-Received: by 2002:a17:90a:1090:b0:268:5f1a:ede1 with SMTP id
 c16-20020a17090a109000b002685f1aede1mr614572pja.36.1691128931734; 
 Thu, 03 Aug 2023 23:02:11 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jv14-20020a17090b31ce00b00263e4dc33aasm3416214pjb.11.2023.08.03.23.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 23:02:11 -0700 (PDT)
Message-ID: <b14e2dab-b425-6832-75ca-4cfabe7ec68d@daynix.com>
Date: Fri, 4 Aug 2023 15:02:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/17] linux-user: Use zero_bss for PT_LOAD with no
 file contents too
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-18-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> If p_filesz == 0, then vaddr_ef == vaddr.  We can reuse the
> code in zero_bss rather than incompletely duplicating it in
> load_elf_image.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>


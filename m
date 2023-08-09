Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D325E7762BD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkNh-0004fS-6X; Wed, 09 Aug 2023 10:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkNf-0004fH-IF
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:41:47 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkNe-0001yB-2U
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:41:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-26813478800so3887268a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691592104; x=1692196904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLGrP4CyInRit21LxZML+ISfZCo2dNhzgh+zsy/7734=;
 b=q1LQ3s+HQ/PBp/GELSsnymFyeWlaVEafdEfMhjiozcS7i/D4t678eRoSZbzf3sqRNz
 EU/klO8oGfIReUusDYw4cOAKX1Z0sN1f2jFXBD//ad78FwkpX3EyuO6ehLUbFn87ehWT
 TgnKqfwsLIi4u2h03QZ/sQdqZ+lgt+ylf+3yjFmZY92rElDthjeGu0st8Hv5ugty9FlV
 No7y1D78vATU3b1+UTagZ7nYncfJ7f0GNwc+aZgyp4K9WEfyy1Z2sakKc9KsXo9g1L2E
 kZhTsAHPSc7D/CJIj6qyfhgUiROuBmAdBIQh5CLPts6oshPENVHZNpzWantgZxlmDjVX
 GTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691592104; x=1692196904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLGrP4CyInRit21LxZML+ISfZCo2dNhzgh+zsy/7734=;
 b=OGJ+1NZJbd5LEH0vksb6wbCGoh1RUOYy6jfeouxBYuU273QJj97GzWomDiZWWsz+Dz
 zogn/cP3fqe4ds5vocNHDKIlvtW5mBBWzdWjpROGSt+mDAivCV8nzbyFnzrZm5N+/xJI
 TdVVLJUgRe+3z1MvVHGGOIV72t45vij+5L42yr5aXbySQbdpwrylbgcVDWDRKLz6s7D0
 PcYw7/bsF6/oY1L+M33p+2gvwIX1NJ4xfqcvn9W0HHUD+xxQz1nzR6XglFasQJk6XnfU
 3h3RnryBys2aq2f+63BN97pZkKY6PwzDYTuHu6I29FNr2KIBvKpfaDogiCvqF5iLtHsM
 p//w==
X-Gm-Message-State: AOJu0YwhdBdhB3hTFgP6NtvLVUnG44Vqnmu3VrXKTSAr03OREfy4i0Po
 nvzaYk/a4B8jPWNvYwDae3cXew==
X-Google-Smtp-Source: AGHT+IFIXIJ+KV2LSEmrYxvpbDCZWKsjRyE/OvHeG44oqDV4Di5GaOm1gnbP3KKwHrJqMFhnvZTsGA==
X-Received: by 2002:a17:90a:ce06:b0:268:22bb:f0d0 with SMTP id
 f6-20020a17090ace0600b0026822bbf0d0mr2121559pju.7.1691592104490; 
 Wed, 09 Aug 2023 07:41:44 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00263d15f0e87sm1631889pje.42.2023.08.09.07.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 07:41:43 -0700 (PDT)
Message-ID: <c982d7b2-248a-7daa-1653-025efb17c195@linaro.org>
Date: Wed, 9 Aug 2023 07:41:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix SEGFAULT on getting physical address of MMIO region.
To: Mikhail Tyutin <m.tyutin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Dmitriy Solovev <d.solovev@yadro.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <bf8ae2fd-158a-57b6-6270-2e56b6506421@yadro.com>
 <ffcb690c-91d2-60f5-3e65-e0be204de7b8@linaro.org>
 <7c2d7791b1af4d54919c51ea6b666dfd@yadro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7c2d7791b1af4d54919c51ea6b666dfd@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 06:17, Mikhail Tyutin wrote:
> Would not be better to get back to initial v1 approach when we clean TLB_INVALID_MASK flag in
> tlb_plugin_lookup()? It works well for those regions.

You're just as likely to get invalid data.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576CB777E85
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8kj-0004lI-4M; Thu, 10 Aug 2023 12:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8kh-0004kq-5L
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:43:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8kf-0000x7-OH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:43:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bda00e7543so5521055ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685788; x=1692290588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ux9G2pCqSQqKT/O8E/3hs4nz5SeBo1jPeCjkfUXNBko=;
 b=JrvPLxEKX2qbeskbB4jeRl3DuYmm0vxQ+EkESDm6SBGx4JdlTXv704luVY7LRZtGX4
 8SI4p4KYWx04rpYw2eW3PT+9hGlMjysfRK8u04T1uUiDd3zxV3/J1A25Eq/kHO+IKoJh
 iavqB9tmBJ2XvBQgdYef8pnV48NTt5/COEGqMR5pAqFAl49uBabtTC/QGs0tMoAUlfLn
 UldAXmBY2XDC+Q6nuoSVL62+2HN80yjapsxSNA/ulXzRbzD3lamVi9Vliehxa+Jh7MPM
 CYq74qQ1KeMuibP7oVWjADxKffB/5IB/H2GG9f1Dn+79qFsONYxPrl2nYow69vZEdegy
 cjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685788; x=1692290588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ux9G2pCqSQqKT/O8E/3hs4nz5SeBo1jPeCjkfUXNBko=;
 b=G7W0/xH41c6Xw8wF9jG0PyYi2gJ2QIFjduSNJ+YPXDB2YQbDVoROdIbk5lOa+TsJi/
 ob+0hyYecAqEWEZqJ5pcA03j7hJGbRhAsFbms8UE63ap0oKthL0dVH2uZ/dNvn0S1XKo
 rfFzExvv9TLdWifgEsufzonUtFI95dfZTqz1Kne6+IQ24q70fgDOHRXzTG87AdFSwaoG
 08HwfNmfCyzdg9CeBipXrqkVrL39mgwkfbWS2U9epvV6JFV7crw0ENa9MmNIlpo8i3q+
 6FByD+L2nkvUyNUD6ibg9s0QepGoH2gH7HLbpUQJocXWIQsCU8CwtAupaAkhsydOxuqs
 2Xng==
X-Gm-Message-State: AOJu0YxEiax0s+ILITzbmBvJN6R9RLUpAf9hKiVZGPyQTT5NTLchO1YX
 jspnDoALC9/8/i4OUupyS+lcHw==
X-Google-Smtp-Source: AGHT+IEqjKc5unTa6bKWScc+AC9ZO1lUJxwZavv0wI+govspMdZFqAvrkf/7flMM6BqgmCs3RjdBDA==
X-Received: by 2002:a17:902:d4c3:b0:1b7:e646:4cc4 with SMTP id
 o3-20020a170902d4c300b001b7e6464cc4mr2935303plg.28.1691685788180; 
 Thu, 10 Aug 2023 09:43:08 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001b66e3a77easm1996072plb.50.2023.08.10.09.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 09:43:07 -0700 (PDT)
Message-ID: <3fb6e5ac-5887-2947-b431-4a15394c347b@linaro.org>
Date: Thu, 10 Aug 2023 09:43:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] some testing and gdbstub fixes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
 <87il9m3ld7.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87il9m3ld7.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 09:35, Alex Bennée wrote:
> So 7 and 8? I would argue for 6 as well given that's a foot gun just
> waiting to happen.

Yes, the timing issues with 6 are nasty.


r~


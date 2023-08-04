Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DB76F98D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnLs-00005i-B3; Fri, 04 Aug 2023 01:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnLo-00005G-Ou
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:27:48 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnLn-0002mG-2P
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:27:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso1540840b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126865; x=1691731665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Qdue3gvVo3TTT0LnUed4RaVsHMA0zZiB4v/wYv9MVo=;
 b=jJbJ7Pnj9gnCCkWsNb6ffErm1Yd6NbY7HpDpzg0cx5H1aSnphLPU8L+YJShp2hr4zs
 CdLHf+LGM8fBOKQPxik+sPnP+lCK6BOxtjHLdGyj+EW68GPFfxIjCGvjmMDlMVQCXLRr
 U3hzQCtbquzEvpuG3BTfymdbuon6/ZQ9D4+O0wW/52B6r6ri4+MdoyUK3Pn32vUBcWg9
 SEv0uOLtiDaMTLK/63GRd5Q9i8TYs01Lu0SW4JP32WRENoZI+RwQgmnmqNNL88Z0PLwO
 m+08wY4OAGyjTlneXE3bSHDhfPwdFIbhLXrYfjW4Rfra95+CAKDHvEIM/+VW9KHiSwIf
 fMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126865; x=1691731665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Qdue3gvVo3TTT0LnUed4RaVsHMA0zZiB4v/wYv9MVo=;
 b=OzpA4VDkVR6geccLPg1h39uTOH+Z7osA0HsH7D/4pjGLpYwwFHgLVkF5e1iv0PihMZ
 hSD4LcruG2171UZ+UKDScAFZKIOXVD376c4sdv0E4PvrA1Mk2iOrpFCGKUJpauyxaby7
 SgIGjiYXF8y4WfoFuD7hmaeHiuQAaXXYn1k4Wz/HAjJgn6ht3ybZIsC7JeSu4G3QfwRe
 kCw8uau8cr0oDrMrTrFV9/4OzXReEnNLPG6p01A8WRpL6oa8JaURBtHiZsGV/ZzHOYcj
 XKOblSYJXBRh0AKstV1Yc7pUm+DZ5A9Tp9wYj6DtapSU/8HJd2N5R4qOcgA4f9SJaOvf
 AdvA==
X-Gm-Message-State: AOJu0YywfQ27RrexnaL2nhUs5fHMSge2D9nEzl4Vvidg8PFL6q0iIG/c
 s4qdvG/lfxa8uzVE6B71w+/0FgaivlnMBw8ea8o=
X-Google-Smtp-Source: AGHT+IG8bN6tn0usd4UKfZOrzo92741Zd7zmM2u/i7RX5IKWaulrRIhtPiJ0iMr82XQNdIMMh/DVhg==
X-Received: by 2002:a17:903:1107:b0:1b8:4f93:b210 with SMTP id
 n7-20020a170903110700b001b84f93b210mr914307plh.45.1691126864945; 
 Thu, 03 Aug 2023 22:27:44 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jh21-20020a170903329500b001b8c3c7b102sm764864plb.127.2023.08.03.22.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:27:44 -0700 (PDT)
Message-ID: <6c5caa2b-94a5-1c45-24fb-feb87342f129@daynix.com>
Date: Fri, 4 Aug 2023 14:27:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/17] linux-user: Properly set image_info.brk in
 flatload
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-15-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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
> The heap starts at "brk" not "start_brk".  With this fixed,
> image_info.start_brk is unused and may be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>


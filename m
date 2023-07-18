Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F027588D1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 01:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLthP-000668-NI; Tue, 18 Jul 2023 19:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qLthO-00065w-E5; Tue, 18 Jul 2023 19:01:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qLthN-0001sA-0k; Tue, 18 Jul 2023 19:01:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b8a8154f9cso1460305ad.1; 
 Tue, 18 Jul 2023 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689721299; x=1692313299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hk+onppxCQFJAmAzZVtVk8kxfI57LiIy6xdHNMa9w/s=;
 b=KRzrcNetKtGo+6IKHSkNYCgIdC+z/UItq2IbHm2r5KEDQoUJlHgV3mmrk8xOiZRdDW
 XjlInWK6GbdkEi63PW0ptXng/ZYej7kTvbXSagYba9oAOSRiN7RecFXChqrnNc+9DMEF
 SjXO7zCTlor2qE3BJ3PoY/Nb2Cgm2qZtdiVhenlLw9gf0MvrtpMFCvvZTKI/eIDk9XfF
 0dOp6jAa6UWjA2x4DrxFBB5qHmlj0clOvFNoZn4hM2ChLPz40/ccwoEfaJGjSXxdfuX1
 tMYuUWxZL2fxs/OZ95UJ2KCni3HS70sJcDJ9OHfpEue03d4OR/JM9H+a7+DEp3caz8Q2
 9JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689721299; x=1692313299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hk+onppxCQFJAmAzZVtVk8kxfI57LiIy6xdHNMa9w/s=;
 b=d0jeRHGDlq1K+1eOFM/AAS3oAMkCfEntP6+GDOBmL+OJG3RS0RVKqAIyp9OvnHdlll
 MndTgWGZSFwkrO18O/bGJxJyifFAPuT7aLRxGy8XTbHFHUv1L1MWQF3rRLgzJfywZ0pY
 g2xyztAZyVtvV33CShuzSIBqjZBKTHVt40Xc6Fh4Kq4E2339IpAZdFlqzeySd5clNesi
 fFoJhw9UJUwNnevpLAZtlc64uURLmmYXKtjb+t9b3NbCca9tIHSgSqwohfFNvTqjbfTn
 h9IX1qUb5cCmwrpB+neVSKfZB8kqjjAenZEbb1nhgsgpdsPW8Az9K5PCfjBjBbut4+vn
 mLkw==
X-Gm-Message-State: ABy/qLayu5P5Q7+FdEfMEkRHepTE2/djh40qJqDfqwG7CdoA0R96/DZG
 +U9TmqiZxrEi+zdrv5cn+Uk=
X-Google-Smtp-Source: APBJJlGHjaFbVy43IXdGi3F6D+bRYgnjhxZMOYQTgZUZv5avl9e4YRTBpnTlyjlfzBnLxgmx5KoFFg==
X-Received: by 2002:a17:902:e84a:b0:1b9:d38d:efb1 with SMTP id
 t10-20020a170902e84a00b001b9d38defb1mr540461plg.8.1689721298650; 
 Tue, 18 Jul 2023 16:01:38 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170902d2c600b001b88da737c6sm2413685plc.54.2023.07.18.16.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 16:01:38 -0700 (PDT)
Message-ID: <46bf0743-e9a6-218b-0f0f-f8f9226f4494@gmail.com>
Date: Wed, 19 Jul 2023 08:01:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PING: [PATCH v4 0/3] hw/ufs: Add Universal Flash Storage (UFS)
 support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
 <0e1a269c-0834-7255-1ded-0d37bddd1976@gmail.com>
 <20230718185626.GA68526@fedora>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20230718185626.GA68526@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023-07-19 오전 3:56, Stefan Hajnoczi wrote:
> On Tue, Jul 11, 2023 at 07:31:02PM +0900, Jeuk Kim wrote:
>> Hi,
>> Any more reviews...?
>>
>> Dear Stefan
>> If you don't mind, Could you give it "reviewed-by"?
>> And is there anything else I should do...?
> 
> Sorry for the late reply. I was on vacation and am working my way
> through pending code review and bug reports.
> 
> I have started reviewing this series and should be finish on Wednesday
> or Thursday.
> 
> Stefan

Thank you for your review.
I have seen your comments on PATCH v4.
I'll send you a patch v5 as soon as I fix the things you commented on.

Thanks again.
Jeuk


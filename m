Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7428271A8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:42:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqp6-0005EE-HR; Mon, 08 Jan 2024 09:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rMqp4-0005Dr-K3
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:41:50 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rMqp2-0002Nm-Pc
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:41:50 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3f8af8297so4802455ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704724906; x=1705329706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gI/kFPhghQxUYGERWA8ynaTcokK71sFs9I6FD2JoC+Q=;
 b=j2XxbolkxFriLzi1oeXAE5tSLP0rg1kgCz/6hu+nbj7SKT2p9sYSqJ8R3RtgsB+Jer
 ua4mBF/qjP1O3nq1kzb7ZTWjCXZQFw6FGAyOFyTH3e+JsuPjhgSj4nOZwUs+bfBpYsbZ
 qMx5ayc4TejqOkALu+YFV+VrgB4Sp1YwboDJUoIFAz9rNND/DdOKZEzTVmP1BQP68lQ8
 8sAv5DOsnT4o4DDmgeGfYOuosQ7Cw0ZuDN0WI1VJoUj4K96ATva278gHA1h2X4gO6+mM
 tVWSmSR3nRQJewzfGqyDCE+gNB5issu/GXva6h8V3kSgm6rD+ss+spujBQ7n3q9Fb8aQ
 r7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704724906; x=1705329706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gI/kFPhghQxUYGERWA8ynaTcokK71sFs9I6FD2JoC+Q=;
 b=OpwQ8rDunxlO0h02ixAthVxzPGwrjoXpdY9ZBcGZ2cTqhK4GHOoC9uCds79+jZQJFb
 bePZmEorU/mFcwpfR37WqxoZEvA03CNxKeAMY7vLmu/5oNyV4DCP6u8e5BmI5IPqN8P+
 +yMJvlBCSaW6wynL3mS6TKL60tAtbU7cBUQCRI8DeUFi64nBYUrsxO48CVw+2s6IerFk
 iVmsmEpT64WPV0XXLtaKscXWuKUTokIXRMCV3CASndmC7B6LeWu4kNmCTr44JxNHfkJO
 +cmGgOxiOKYKUe+ppVrC4EMpyBKbVEDEemVClUma3xhZn5cfLppU/Af7bdqa49LF095r
 TyTQ==
X-Gm-Message-State: AOJu0YyHp2TDc8n7DSn5Gy4mhCqsD4GRYJgdeMJmBsRPEO21dQs6+M2y
 opoXqW8VJbo1ypDhw4dB/Rc=
X-Google-Smtp-Source: AGHT+IEx9B5jATjqoEnbko9ksb27/ttrn3gYZZEVr7Ui+Obwk24elqjqDMbFzIKLGBRImFUVMTSG4g==
X-Received: by 2002:a17:902:7884:b0:1d4:e1d6:14e7 with SMTP id
 q4-20020a170902788400b001d4e1d614e7mr1463643pll.105.1704724906547; 
 Mon, 08 Jan 2024 06:41:46 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:8dc7:dc76:2790:235a?
 ([2001:ee0:50f4:9050:8dc7:dc76:2790:235a])
 by smtp.gmail.com with ESMTPSA id
 jh12-20020a170903328c00b001d49d07eb10sm6405041plb.218.2024.01.08.06.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 06:41:46 -0800 (PST)
Message-ID: <0fecbb98-9019-4a3a-a764-38e848b5b238@gmail.com>
Date: Mon, 8 Jan 2024 21:41:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CI "pages" job failing with incomprehensible error message from
 htags
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <CAFEAcA93kpreNOOKz6-qbVE_9Kg6tgZNaMowNLwc+G_47MXLHg@mail.gmail.com>
 <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 1/8/24 18:03, Thomas Huth wrote:
> On 05/01/2024 20.11, Peter Maydell wrote:
>> https://gitlab.com/qemu-project/qemu/-/jobs/5871592479
>>
>> failed with
>>
>> $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
>> sourcecode"
>> htags: Negative exec line limit = -371
>>
>> Does anybody have any idea what this is about ?
> 
> In case you haven't spotted it yet:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014394.html
> 
> Is anybody already already creating a patch to clear CI_COMMIT_MESSAGE 
> when invoking htags ?

That solution works fine on my CI, however, it is stated in Gitlab 
documentation that overriding predefined variables is not recommended.

	https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
	Avoid overriding predefined variables, as it can cause the pipeline to 
behave unexpectedly.

Thanks,
Quang Minh.


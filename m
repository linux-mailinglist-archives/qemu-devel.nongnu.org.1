Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F07A3186
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 18:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhYcL-0005XD-JV; Sat, 16 Sep 2023 12:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qhYcJ-0005Wx-Gi
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 12:57:59 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qhYcH-0004zK-ST
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 12:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694883471; x=1695488271; i=deller@gmx.de;
 bh=3zCCFWfLejvfuiC5E4VlUCWZPoyVDyDDgJ+hR/5ERrc=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=TUGJnm8COhoRGq43YQqNTdFMvz2Glb95gbTpTcZ5F/I8JUDJYBtqyfrbdN9kyWwf9VfqaV5tCZi
 ASK+cF2rXhAN7LzWgfv9lp2auQY3s6bmowC3Owk9P4Xn1GCjkXUxOSZLjN/gERrKCZqEYWKy5BPZF
 Mmc4+NZrWXqdw9nKMlCSEL6oByhteq4AjB821viKnuguxTKS/lt4FQ8t6TcoA+I4MRyQHfw/72Y8Z
 76lQk/RCZ2RaXzdUWHBch+Y+Uxc/Y6kYmWvFpz0YlYwcVhWWUZeSjYkQeljatcXZtSHw+hUxnTflB
 KcZPH7gQRI1UW9BqEZ5kDUo69PO4XYxGUKvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.45]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1r0RsG2qIp-00LobU; Sat, 16
 Sep 2023 18:57:51 +0200
Message-ID: <741fb0cc-8844-b892-7eae-26d5b14bb5dc@gmx.de>
Date: Sat, 16 Sep 2023 18:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hppa: clear the PSW 'N' bit when delivering signals
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Mikulas Patocka <mpatocka@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John David Anglin <dave.anglin@bell.net>
Cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
References: <f69ce25f-733d-7931-e59c-e3f1279b965a@redhat.com>
 <bb1b594d-5526-7774-44ab-bab8c5262c49@gmx.de>
In-Reply-To: <bb1b594d-5526-7774-44ab-bab8c5262c49@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+3SD+I0PyWQbf4Sf8al36nUVGA50gj1kVEZ0yyV85IXroRr8W3N
 ORVwbvLfLyNHE+gcvy/rMGprFY80p59xjhnMNH9mPKFUjOr0RXfrxtRK/MoITpyWARv9fBu
 WvLNRbp5r3qhGoXu2oahpIPBNlPYgQpFiiJq5ArOF4oWdo7dIvgJ1QyMR4Q7C4HKGJ4F9F+
 tYcy9Vjb4nE1mPW+qr2Pg==
UI-OutboundReport: notjunk:1;M01:P0:U0MEenLZvrM=;wqQ3uMaIJGRe0JsXYKmPW2Jhp9B
 c5FPy1oMU6RP4a2T9pXnxhbsJnlN4lzTf5rErnSizYckwds/ZV5cHHw0m3l+kU60sfLRvDe5X
 Fai//bhx35Uau3jQ+WA8tA/Pdgkkwm7XwBejhocyYk2Kg9Z/2caVNRVVk3XuyOb2TRD96WHu7
 cE5wKIVayerG5jdNbfa5t8GxI/ZbzI7pFUmdfVLjV72TmGzcHjHEec5G/Wxpmg6qNK0JsYJyO
 ANXQi0yOkWiRwBq3z7PWLp4qWGNxn2UMhfx8EK0NK3RBt+tpYlRzXDqVeGAZlK7etG6ImRyjf
 5GpRW51Tgg9gBsM7nfyxRqLehu4jqtWoK9EkB19r5lrVkJe2uhWPY+oZzMEMsCkRHCVIemM9J
 a7rN+Ymct5PK4BkLgHUSsdGuXcx4wUjAQhYciKAxYoh1bJz62fT+IzKy9zR4A26hn60hBxLxN
 8JT6RXIzLPRq0J/4eq2oJs0enbQTmF9kxujhMBg3jYJQ7MN87b4Aq+8nHARQ4r3OMMsGeVCKA
 9QcLWSWW8Yu5AqwQjiYC3gfFxhraEfqAZqK+HQNiEfWp5Vk4AzYRT+qbtbi417j7D4TnxAjGI
 9sUaLymw9hxCiVxa6+bBurYnz2DUqM0zLEoS6EvdId2J9+0stifQhf6otwgs3XsOW8Bzvb89A
 HlU/tF4d8E38soz6L7SJYNlW3x1js+1zFA9vxy26mKfTF6Spe7LIEHzpv5fpOuqHBxgCfBaiF
 TTRf+xKnZhzU9dbErALppIf2qJ6T0TIgVJM/9TAkF/KpP5JfY4XM+3DmlhEnG6kq2afPd3r64
 c+zUkYKJL7agZN0Kh7KnAp2IWCNDVr0+WGaSdlcnXUVzN8X41NcPm3vKkik/wU8g/+Gl67mtW
 SBudeVB01UwuxTuxOndO4vDZfkNjjJZG/Y/zfLitzeLPE65hm4wqxryBEaNTw5SF777DMq36d
 WNkJR2iP/nAk2MdQ890iIMbpFKA=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/16/23 18:49, Helge Deller wrote:
>> The reason for the crash is that the signal handling routine doesn't cl=
ear
>> the 'N' flag in the PSW. If the signal interrupts a thread when the 'N'
>> flag is set, the flag remains set at the beginning of the signal handle=
r
>> and the first instruction of the signal handler is skipped.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> Acked-by: Helge Deller <deller@gmx.de>

FYI, I've queued by both patches in my btlb branch and added backport
to stable request.

Helge


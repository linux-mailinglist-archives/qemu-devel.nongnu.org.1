Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA13679C30D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qftFO-0005ZO-52; Mon, 11 Sep 2023 22:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qftFI-0005YF-PR
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:35:21 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qftFE-0004Cz-Te
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:35:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c1e780aa95so34230325ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1694486107; x=1695090907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cvSrAEGX5qMYFzHXHPrcZZTDY7jZ/z5VTU5dE+s2ajc=;
 b=XliLnRw3HjKCWKzrMdi0i/XislZJ+9GFjb5TDl4M4t4szA/EcJEL+8PzItKlVIxZDR
 wRFYlXQfKrw9PlmSDsovVCysQLt0be2BLSo5eb4/oJ3ERaGG7BiUlDNjVWHcRWbSsVwy
 3b8Q3Axe0jvdv1wuXO3BB2KwhTcoBfZkEqLhMNot5JB0a4O2+oKpqu80D5fGKKsqptxx
 jf09I2eeJeLhY40+MTaFHXjxhvQ1m66LWpPIPxhYk9h2X9mia/vze7IhawTsZv5yB0tQ
 nKYb4+Vddb/7CW0W5htj1wsECryg3FGt0Lzuv+CQ5wXtY2lnnKHyKDqiKj7+My44+VTu
 oUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694486107; x=1695090907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvSrAEGX5qMYFzHXHPrcZZTDY7jZ/z5VTU5dE+s2ajc=;
 b=BXKrJHZxu74tjuKCsnrWLKwH7gdlfWnmRF1z90IkFeygLxLJbVqpS0f9N9JM4O/UEW
 U89f83cql5Qh2KxQlrHCiao2fhNwZ2xYhrDFviJ3MFQvmA+bXNff82+P/2NQhS2sy8Cx
 j+P2NqbYGKPn+cKW1IiRTV66g30CUdr5n14gZGGaWejJGJXMRWXS3VgQBoTZJpUARKOC
 RU4+eE6hqj9UzSKfMrDrPr//HWLZoGg32iWRzdW88+veBjKbjmyx+Sw1A5T5vTbW0Ds0
 ZN5GwTizLnk45W6ZnlITF75Z8gaeeIh6HIey7CQ+T/z+vcHmx6TUY7iXqZKZTFClImJP
 syjg==
X-Gm-Message-State: AOJu0YzmNiaRsmuGxgxF1zrpUJ+K6xIVAj7oFG0PAg5+5CnAft/99DyD
 NaSibUfbL56fW/L/9xI/i6SAMg==
X-Google-Smtp-Source: AGHT+IFgOiP7Ri8LE2af5lp1JLJsOp5vo5sBI/M85pmwXr8Q/pKvjBXpTzna1BJqaKjJpWTHagzc4Q==
X-Received: by 2002:a17:902:efc1:b0:1c3:749f:6a4f with SMTP id
 ja1-20020a170902efc100b001c3749f6a4fmr8371258plb.54.1694486106396; 
 Mon, 11 Sep 2023 19:35:06 -0700 (PDT)
Received: from [10.84.153.58] ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a170902e88600b001bbdf32f011sm7114987plg.269.2023.09.11.19.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 19:35:05 -0700 (PDT)
Message-ID: <978c964e-37a5-4efb-a25f-542a3d518520@bytedance.com>
Date: Tue, 12 Sep 2023 10:35:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2,1/1] memory: avoid updating ioeventfds
 for some address_space
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230830032906.12488-1-hongmianquan@bytedance.com>
 <499fe9b1-54f5-4d0f-ae2b-165cb0f3e6b3@bytedance.com> <ZP9AIScw8GrKZNlR@x1n>
 <6841f996-497a-3420-9447-524295179535@redhat.com>
From: hongmainquan <hongmianquan@bytedance.com>
In-Reply-To: <6841f996-497a-3420-9447-524295179535@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



在 2023/9/12 1:55 上午, David Hildenbrand 写道:
> On 11.09.23 18:28, Peter Xu wrote:
>> On Mon, Sep 04, 2023 at 08:51:43PM +0800, hongmainquan wrote:
>>>
>>> Friendly ping...
>>> Hello, this patch has already received a R-b from PeterXu. Could you 
>>> please
>>> help me review it as well and see if there are any issues? If 
>>> everything is
>>> fine, could you please consider merging it? Thank you!
>>
>> Paolo, wanna pick this one up?
>>
>> David, I know you're preparing a pull with a lot of memory changes, if 
>> you
>> like to pick this up it'll be good too.
> 
> I queued it to
> 
> https://github.com/davidhildenbrand/qemu.git mem-next
> 
> If nobody beats me to it (or requests me to drop it), I'll send it 
> upstream next week.
> 
Thanks for that! I hope it can be successfully merged.


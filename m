Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5FB21E6F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Aug 2025 08:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulibc-0004ob-Jf; Tue, 12 Aug 2025 02:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulibY-0004jM-KA
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulibO-0000jw-QR
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754980514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+/VdDIS4xyL+f08Bd81t5OyYqBPLnZW4DgIwBKtdZ5s=;
 b=esvrbXYdmVV0WLQOZQ8IdApeFxT/hzPaSzZJATCG8KvCEAJ6JqrLB79rDsWWgvHVypO+iG
 jmuq58d9bQTRALncVh6r+wKtMrhtStpubtv8CBoEOAuRbg/nRX782/zAZBE1X0UzLMT/Wf
 Uxt72x0xpb+1I8ZuKUHOFUuRhdY2JzM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-mtjsYVM0PjmOSHgtZ6TxWQ-1; Tue, 12 Aug 2025 02:35:10 -0400
X-MC-Unique: mtjsYVM0PjmOSHgtZ6TxWQ-1
X-Mimecast-MFC-AGG-ID: mtjsYVM0PjmOSHgtZ6TxWQ_1754980509
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b780da0ab6so2557799f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754980509; x=1755585309;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/VdDIS4xyL+f08Bd81t5OyYqBPLnZW4DgIwBKtdZ5s=;
 b=Oo55UO+Ed7Wt3nVEG9Nen1a2mds3J5eIOTGDfjB15edzhdkj9o/LUoVBFVo93K7YoQ
 FEoXKY0TWAPiybh3QmhVuCzPR+HMxSYbwvNOyVTaGB8AKDaSOwB3oNPUGkA/uNlJEnSd
 4za0hn8s8rflXXX2pP5HC3pHu4Ji+nBWMg45QG23FS+2n5EyU1gC3Ftd3dvUUXz0KhpX
 vBn4uDijeN2WYmeqpmcIUKAoyUFiBLA9o1pruOz1VYhvBx1gJ/dkEY60BAf2sWUe1+6V
 wUl7G47PnDt/e2QUkmqTJ1QmPzD7ChvT3wXbtfitRidd8G9SNM8AbopNXI9fYUBNWoBm
 uz1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU05QniE/1P/CoJ08rtabE5NF1fWHlDz9KawHYfYHKGIUw4kXS0R90rFJqyLwfBuYhQAj/QzdoGnoXQ@nongnu.org
X-Gm-Message-State: AOJu0YxbomUbke/vThEr50frK51QDtZFJMxD81H4aniQ3+w247QobQF0
 FR3fRQQfYEGuAYChKIKM8OvVkuMMA0LsBA0ayzsF1oQ0EhmCjAcS60Rg/j/N2ISTRm3Knnbkka1
 LRKjF05n0cS14abuXo6rvrm+BGs/Pz73VUgudy5Xa0JJhEZchCxnB0oB1
X-Gm-Gg: ASbGncupF2EJDK4pdrsyc1nyP9ZSbTQ7hsxTz4GT7uGeNnLrut+U18+OJ2TcMnTZLCY
 rHSBI6VjRJcvkaF+gPUpIussaz8eF/aNKammgSaqDzQbaTC+ggESM9IYCkulKPkeBY7k0N4iVhj
 g/IqSaXHVm9lxqHmo66fpHU1UbLMaYfjbKGoo0ZRZgQTN/ukMZzxgjZWuamIw3wsodkYLbKV1Sz
 Y1gAxQ6pR9/U6qAmgcL5rLnp9VnW/q8kH6N4QFu+S9PdR5zS0hGfNBjp9X5x7OpkVWbuOwrk25B
 Ba+gtiJLaVEc++KUFnOwUyHM2v27OKP+nfy3TxDCdm5B1LXtLP2H+mp5jaXzmriUEZCNcHhmMrj
 9uw==
X-Received: by 2002:a05:6000:24c3:b0:3b9:10c5:bd7d with SMTP id
 ffacd0b85a97d-3b910fceb9fmr1708358f8f.10.1754980509376; 
 Mon, 11 Aug 2025 23:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEmYABXVfbZIlTEBe8JIV/8PErKcnCBtrt3dSO4uQ0jJchfWCif6y7LvzZam9Il3yXTtwjfw==
X-Received: by 2002:a05:6000:24c3:b0:3b9:10c5:bd7d with SMTP id
 ffacd0b85a97d-3b910fceb9fmr1708337f8f.10.1754980508899; 
 Mon, 11 Aug 2025 23:35:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453333sm44590041f8f.45.2025.08.11.23.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:35:08 -0700 (PDT)
Message-ID: <b0bbbca8-7c4b-4348-b0a5-e7e62d4b1714@redhat.com>
Date: Tue, 12 Aug 2025 08:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] vfio queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>,
 Steven Sistare <steven.sistare@oracle.com>
References: <20250810160118.450430-1-clg@redhat.com>
 <82cbd755-e949-4215-a150-441553a1c3bd@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <82cbd755-e949-4215-a150-441553a1c3bd@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/12/25 07:55, Michael Tokarev wrote:
> On 10.08.2025 19:01, Cédric Le Goater wrote:
> 
>> vfio queue:
>>
>> * Add documentation for the use-legacy-x86-rom property
>> * Preserve pending VFIO interrupts during CPR
>>
>> ----------------------------------------------------------------
>> Cédric Le Goater (1):
>>        vfio: Document 'use-legacy-x86-rom' property
>>
>> Steve Sistare (2):
>>        vfio/pci: augment set_handler
>>        vfio/pci: preserve pending interrupts
> 
> It looks like 'preserve pending interrupts' is a good candidate for
> qemu-stable series (10.0.x), but the patch is rather large.  Should
> I pick it up?

Nope. It's CPR related which has been merged in 10.1.

It lacks a Fixes tag. Sorry about that.

Thanks,

C.



> (FTR, it doesn't apply to 10.0 due to other changes in this area,
> and looking at these other changes, maybe we should pick up some
> more fixes?)
> 
> Thanks,
> 
> /mjt
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533707F96AA
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:53:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7OwO-0001tt-K3; Sun, 26 Nov 2023 18:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OwL-0001tK-0s
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OwJ-0003xj-MR
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cy/y763DftHJ+hWsvHB8+IyT+wDV3vJAmTxUoE6n1X8=;
 b=aybs9wt3u7X0E3/5QpzPnABqtDAG9NiHGF9PjgkuNEG3sQljbVrYNq5rUc3Ap4joErh6hN
 IwTfbWuQowaAJQ/yaRWrfAaIcPBNyVJp7FKNohmk17CPh96n6P+Xxx8JL6SEKQWtdCDXLw
 GIifrqf7TAbz0bQ5AlQjzuFUncOLz9g=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--7JLCnbLOVede3FN1mbtEQ-1; Sun, 26 Nov 2023 18:53:20 -0500
X-MC-Unique: -7JLCnbLOVede3FN1mbtEQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6c4d0b51c7fso4728612b3a.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042799; x=1701647599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cy/y763DftHJ+hWsvHB8+IyT+wDV3vJAmTxUoE6n1X8=;
 b=NtbNGCViBdrgpqXBQ/BAvl0F62CINWz4obo+TUmYEC2Bl3q4dTVDjLlg1nXwrBqN8w
 MUwKDt0l9BlUOds2aZ0zANFL3ygMCXAnHxqwNljfkAMTUSNyRlHW1KVj2nqrhuPev2Cn
 /hNOKccZte3en5MEmWf/xQ7hF7vpgupjI4rq0q9nEGVBimB9Owh2VYOBTl9biZ8Zvozo
 nv9pt0nT+NCd2QTPqIk5l9MUhtCKh9ep3+6hMy+0eQkhzakivQR+oH4CjU9NdHI/iDVj
 zpkE8x5WmDz4QoCnsWxaJ479rMzchw5REWvuqlED3/22S7KHo6USmHebMZu5usOMm6ib
 IEOw==
X-Gm-Message-State: AOJu0YynlLS5iFqiycLWMCu6DUYVJome9UOMuLNu/p+99lpJGwk728Cj
 mksge8V2dsG0cK1321uXCqxJt3RO2WXJtmbDFQP5u88X7+26k9nk864Myh2k3c6oCeVxZfopW2p
 c71z6BXijUVlU2f5wFVl5AY0=
X-Received: by 2002:a05:6a20:160b:b0:18c:1af0:ad56 with SMTP id
 l11-20020a056a20160b00b0018c1af0ad56mr7708897pzj.8.1701042799119; 
 Sun, 26 Nov 2023 15:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGGIGQBUnhq4fC3MlgxfHAAJCR0fzbREhoJBXiS6KrvBM9ETzEc95PsOEOojtwI6hxJj1zsQ==
X-Received: by 2002:a05:6a20:160b:b0:18c:1af0:ad56 with SMTP id
 l11-20020a056a20160b00b0018c1af0ad56mr7708885pzj.8.1701042798824; 
 Sun, 26 Nov 2023 15:53:18 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 x10-20020aa7918a000000b0068c10187dc3sm6044141pfa.168.2023.11.26.15.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:53:18 -0800 (PST)
Message-ID: <bc9bfb15-3b4e-4a52-9114-4764f83f6cbf@redhat.com>
Date: Mon, 27 Nov 2023 10:53:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] target/arm/kvm: Move kvm_arm_handle_debug and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-8-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  9 ------
>   target/arm/kvm.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c   | 70 ----------------------------------------
>   3 files changed, 77 insertions(+), 79 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



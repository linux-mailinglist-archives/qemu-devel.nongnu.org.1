Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514B7D57CD
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvK5Z-0002Rl-LY; Tue, 24 Oct 2023 12:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvK5O-0002Jp-Ul
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:16:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvK5L-0007ex-Fv
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:16:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32003aae100so3371828f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698164208; x=1698769008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QcongjLqzWg/eaT6MU2YnNd1mAYK2XTOvuPPmT1yxec=;
 b=QiuzduirN2nqrpwuU+Xqg/A2PNh0euZj0IkLSymYL1eGV7T5a9V5EMCdaZflMomtQl
 ikon8myCWHtJ5kmUlS0GUVfn4REhaBD29Zw8pBvS657USxhOWndwXXzvpNDD5eVSP8Ep
 L25Cun4+57NP7dxI62PxAqWSDrWJ5+8HiyjhZ0T89oN/UyJkf8t6MfHewgi/4fs3c1hb
 xqqUJInv/9SGqMAzNGuz18ukz1cTy3HlDEMHU28nYiKcThKl/xXFYmVv26BRkvsMSQCx
 kmWqZ37l6K4ay9YnuvTnd8CxIrcRb6cmAxg/voMVaio2uHci60EYe2oRhXiDWGLe8j0A
 yB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164208; x=1698769008;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcongjLqzWg/eaT6MU2YnNd1mAYK2XTOvuPPmT1yxec=;
 b=ssONS+N7t1lN0lLNCW6BI9lZ24y192+MNYQymceNoDdpsrznJejVvA3x8BbSSIKemj
 K4wtqzARt88ocAGZWOntpnsA7h18bmyike8dX6cRvoi5jnTUATdNB+b4l6crq+RhYjiq
 p+7nXs/ytJuogNSap82IPc+iCnT7252OUsazPwVXx2ZfgWV2C9EHJDKvOQNY7exxf4+4
 hrzUMp+D0/dySaHgIt77usLG4hRdz5HwbKg8bSjjAKTKZuY6ph41oz7BZNNcMSd0yJXE
 hmDkPddXR7VG5VOMYs8VAYzTov2YbgaoeLquqeUlAsNpLhxr71wlTBfb6D331oEXwbM7
 tGlg==
X-Gm-Message-State: AOJu0YzUTDQkFBK2h9NCBR6atB8GjsF10YdUkAZCFD3cX0m7eBkm5CCZ
 uOHllKIThe4CKgJXEVWYDXpKhxlKAuzbZw==
X-Google-Smtp-Source: AGHT+IFyYoxCffK4vqNocIJcq/bwK4C7n6go0YOsNpyudOwqbZGUABlQoetDH9qYu8zxPmI97nOj5g==
X-Received: by 2002:adf:8b97:0:b0:32d:a3cb:4059 with SMTP id
 o23-20020adf8b97000000b0032da3cb4059mr14684996wra.24.1698164207951; 
 Tue, 24 Oct 2023 09:16:47 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adfe7d0000000b0032db8f7f378sm10249114wrn.71.2023.10.24.09.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 09:16:47 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2e174934-afca-440b-9edc-a5225d2510ea@xen.org>
Date: Tue, 24 Oct 2023 17:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/xen: update Xen PV NIC to XenDevice model
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Jason Wang
 <jasowang@redhat.com>, xen-devel@lists.xenproject.org
References: <20231017182545.97973-1-dwmw2@infradead.org>
 <20231017182545.97973-3-dwmw2@infradead.org>
 <53e3e3e3-7bdc-4102-b833-bcacd496a31f@xen.org>
 <72ea536333fc9942f3c39acee571fc8f5ad98ba6.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <72ea536333fc9942f3c39acee571fc8f5ad98ba6.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 24/10/2023 16:17, David Woodhouse wrote:
[snip]
>>
>> I don't think that's really a valid state for a network frontend. Linux
>> netback just ignores it.
> 
> Must we? I was thinking of making the ->frontend_changed() methods
> optional and allowing backends to just provide ->connect() and
> ->disconnect() methods instead if they wanted to. Because we have three
> identical ->frontend_changed() methods now...
> 

Now maybe... Not sure things will look so common when other backends are 
converted. I'd prefer to maintain fidelity with Linux xen-netback as it 
is generally considered to be the canonical implementation.

   Paul



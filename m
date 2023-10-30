Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1AD7DB9CE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 13:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxRHQ-0000Tk-Ab; Mon, 30 Oct 2023 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxRHL-0000Rg-Fo
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:21:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxRHJ-0006kw-Oa
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 08:21:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc5b7057d5so2342615ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698668516; x=1699273316;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VpPJhVMSLhTXAOowZ5/k6CbXXPkeWdD5xfumxT3qW2U=;
 b=cav8QUfF/902fig2ukGfwEOpuahGnkl3B5BmNeDv4t7eNc7V5nN7q6qtByEWgstv9n
 /xmAzhXiKNCMPLZEXZ0p6r4Bc5+y8Evc5XkQInZXT/5IK3EvQnC31f4C4ipcnVZgjr/W
 IJxZSpVReVH5TsmeNEdmBybxlHq7SmhdJs4NAtZmDSbAgJKaUy/ZRjBhLEaIdyDjyDeS
 RiY0PA03ln+oWXPSgsspioN7u357ZRtOYg8/7pdMwBRx5nNCtH2IiDFwNuEeA1LBwVkE
 7HrWIlnQ6Od6pAnPsEDb2VQa+QcCiZAUT5vX6Xb1b51GAnTIKQoMDJaXSCp8/AkNG1Hm
 fTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698668516; x=1699273316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VpPJhVMSLhTXAOowZ5/k6CbXXPkeWdD5xfumxT3qW2U=;
 b=QpEzbXRHjkZMcA/wuSKMeV9qr/gFcacA/LDdIMeYuSku9TxQrRKKYSpH39fc1sfwLk
 7mDxZ6Cpa8iex+Iqjp2v1Q+pHflP2OJ6oJGUoVvP6bvylW1ChyJv4BAZE14RKWTIzqEd
 mBbPQ5KyFz+W3JcmEbizXWdBpN3YEI7feFhs8DtroCnz2YAhFT8I9Ap3Nir6YBfpMmL7
 yWC7Gud172BIFDosY0sqUcw/VSc/saacCIx4lacn6UZjRM33buLHGOkAS3h0gqPxKcNc
 KCs6r1A35XMBAkyFF1n6x2mNrivXn+gTnW+LdjUGx0Q9rRfn14w6MBXvKuhbeozIwD+A
 gi2A==
X-Gm-Message-State: AOJu0YwtxexovMfi/NNRRInYAjYQbykSpVOkl35FB8IL2hVfBWYVhqDE
 +Pep109qcGUzbWCgdBkZ8S86FQ==
X-Google-Smtp-Source: AGHT+IHTGVeSxY1y33wT0Y4Y2lBdgSzt6YCPKuqWQD8ZxKkPTJ23wYrT/l2So1VYIJ0V/7STlQ1tYg==
X-Received: by 2002:a17:902:e811:b0:1cc:569b:1df4 with SMTP id
 u17-20020a170902e81100b001cc569b1df4mr1241147plg.1.1698668516385; 
 Mon, 30 Oct 2023 05:21:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jh15-20020a170903328f00b001c7453fae33sm6204178plb.280.2023.10.30.05.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 05:21:56 -0700 (PDT)
Message-ID: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
Date: Mon, 30 Oct 2023 21:21:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/30 21:14, Yuri Benditovich wrote:
> 
> 
> On Mon, Oct 30, 2023 at 7:14 AM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     vhost requires eBPF for RSS. When eBPF is not available, virtio-net
>     implicitly disables RSS even if the user explicitly requests it. Return
>     an error instead of implicitly disabling RSS if RSS is requested but not
>     available.
> 
> 
> I think that suggesting RSS feature when in fact it is not available is 
> not a good idea, this rather desinforms the guest.
> Existing behavior (IMHO) makes more sense.
> We can extend this discussion if needed, of course.

This change is not to advertise RSS when it's not available; it instead 
reports an error to the user.

For example, think of the following command line:
qemu-system-x86_64 -device virtio-net,rss=on,netdev=n -netdev user,id=n

Before this change, it gives no error and the user will not know RSS is 
not available. With this change it now gives an error as follows:
qemu-system-x86_64: -device virtio-net,rss=on,netdev=n: Can't load eBPF RSS


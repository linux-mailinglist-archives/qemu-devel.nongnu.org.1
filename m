Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C7A164A2
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Jan 2025 01:36:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZfkk-0006qF-Cn; Sun, 19 Jan 2025 19:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfke-0006pp-58
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfkc-00046p-GD
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737333283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GFUHYV/seV3Hjaqoj1ZH6QUB25vK2U6l1rlCmzHnLY=;
 b=RFKRNvRuyXFQjX4bZyHqAlwadt0IQEvaDlYPyvND130w5kzK9w3S6h2gpzI8WjU2gzo0zm
 n90q8+aoXlJRu2QmPloZn05mTgU28e7v+TjHQVUsb5bZbD+p8hBZMCNytb8PrzdRBR5y/X
 N4R/z+RZS4dqCnA5MebWskHfUbXKQ7c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-YTcjkOY3OtKwKACr01asAg-1; Sun, 19 Jan 2025 19:34:40 -0500
X-MC-Unique: YTcjkOY3OtKwKACr01asAg-1
X-Mimecast-MFC-AGG-ID: YTcjkOY3OtKwKACr01asAg
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-21638389f63so54691875ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 16:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737333279; x=1737938079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GFUHYV/seV3Hjaqoj1ZH6QUB25vK2U6l1rlCmzHnLY=;
 b=RwRMHEiI5fryoQ6X3xzEH2PIQ7jvxcGeQxIUErmcpLYyXqPF/SJvdjT5bNOdwOh1w2
 uc2VC07gVxqaHNGTDcCdGPOuXok/74RPxM3sQ0OfD886w3vYnRWsBZrjWBWWdLETQ828
 OhZVGp5HyJ2eZMt2Ee5Fzo6TqBAAWq4qITbL3LDOb2U50BsQ06HpnLniPkmCIfwoSmHj
 tWzvaDoVsZZdAPZPQiIWSWlJGiTQFfxqD9piZslOKaYuRhJzoOmWB2Laj/b3zOJnxd8E
 CbPH0iCBrcCU4jYlceCVIl0zWxT3kXdunlObv41aT5/Rzht739amuFrLEfj2+2jlEbJv
 mkMA==
X-Gm-Message-State: AOJu0YwFhzZqZDT45SppRlTrHmFAgkL4l8K3T9oWLMNNFf0eCYyPwHRd
 u811Rrc4G4j9Cf2D/uxL+/R7vlXmVhVR0J7AYZg9sUEc7fjFeS93plcP8WBDXzhp0W6LZgUbDG5
 KWjmsBu4zV/HPUeZazys+JTAFXPcnb6cLexyJU8J3clQ8D+gCF05KGdn1u3CzUNpmYuVKdx6pjO
 4zf7eNk1Z7UieJfwAPcPwdzKI2CkM=
X-Gm-Gg: ASbGncsroyGvGcdimPLSBbooV6j+frrjEYZgWhWChoxtF+cmc8CpZ1mAvTOo4opUp2M
 bpdASxZzxfEkldtBEX9/8eRvMB6IrTk4VZWVCbUi52DiqasKZ9B32
X-Received: by 2002:a05:6a20:2450:b0:1e1:aef4:9ce8 with SMTP id
 adf61e73a8af0-1eb215902e2mr19277467637.28.1737333279496; 
 Sun, 19 Jan 2025 16:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj2/849JogWqXkYAYAsZ3ZAMHonrC5d4j2Pa2cRXJD4RIm9uCa8gPsDjZP2McaLp2DnMK4JyC3HQRyBRtEA7k=
X-Received: by 2002:a05:6a20:2450:b0:1e1:aef4:9ce8 with SMTP id
 adf61e73a8af0-1eb215902e2mr19277438637.28.1737333279026; Sun, 19 Jan 2025
 16:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20250117111709.970789-1-lvivier@redhat.com>
 <20250117111709.970789-2-lvivier@redhat.com>
In-Reply-To: <20250117111709.970789-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:34:27 +0800
X-Gm-Features: AbW1kvYOCljyka5nKFSfdYuMlJhJTlGPKhJj4hTN6-69U0OC3DO3r7cBKoQVJzk
Message-ID: <CACGkMEs+bWdxmaE6wrcZsomPb0Jt4UP=RWTaRxfpkEqgTdbxdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: Fix announce_self
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 17, 2025 at 7:17=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> b9ad513e1876 ("net: Remove receive_raw()") adds an iovec entry
> in qemu_deliver_packet_iov() to add the virtio-net header
> in the data when QEMU_NET_PACKET_FLAG_RAW is set but forgets
> to increase the number of iovec entries in the array, so
> receive_iov() will only send the first entry (the virtio-net
> entry, full of 0) and no data. The packet will be discarded.
>
> The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self.
>
> We can see the problem with tcpdump:
>
> - QEMU parameters:
>
>   .. -monitor stdio \
>      -netdev bridge,id=3Dnetdev0,br=3Dvirbr0 \
>      -device virtio-net,mac=3D9a:2b:2c:2d:2e:2f,netdev=3Dnetdev0 \
>
> - HMP command:
>
>   (qemu) announce_self
>
> - TCP dump:
>
>   $ sudo tcpdump -nxi virbr0
>
>   without the fix:
>
>     <nothing>
>
>   with the fix:
>
>    ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, =
length 46
>         0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
>         0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
>         0x0020:  0000 0000 0000 0000 0000 0000 0000
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Bug: https://issues.redhat.com/browse/RHEL-73891
> Fixes: b9ad513e1876 ("net: Remove receive_raw()")
> Cc: akihiko.odaki@daynix.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



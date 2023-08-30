Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779678D52B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIi6-0004W1-Dk; Wed, 30 Aug 2023 06:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbIi4-0004Vk-BT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qbIi2-0006Yb-Ap
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693392361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwhm4ZI/fCOj7gn4h/KTiKU12XKUCHQDDtXN2OxnAnk=;
 b=C45GvRB8ZSE3FG5/l/jkl7lyLZKrGc567b3Vc57x5pZEJ8vBUJ93ODFCgtc6NmzOV74MLA
 D2c4OwJE9JglfEZqS9bMgj8FZ7B0Ksq1vt5K0lNcG7mos8HVCaQBAtsF7XHKox3wMwjbbf
 VIwApZsIo6nElheLnZ14Fc6nexn3Nhs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-0rrra1ZfMoWNH5JYSxzXlw-1; Wed, 30 Aug 2023 06:46:00 -0400
X-MC-Unique: 0rrra1ZfMoWNH5JYSxzXlw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52a62955316so2493293a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693392359; x=1693997159;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwhm4ZI/fCOj7gn4h/KTiKU12XKUCHQDDtXN2OxnAnk=;
 b=Hj6YOOPeFCcOBdBwSQF2O7WhvE+Fr6R/qiYHXs4gwh897bsCFgii8ewOKFqmuJvjKO
 3lgDKQleUs+DtNCUXR5m5dJA6NkqvaXBK84uUBopj2Bz6GackfloIW2MZ/F+cVW+mCkN
 T8TqkykvXK6oaGxLK5TQWb81Yu4wmpmIzBWuwGnnIQtt3CvtJrkRJGKtgoeW8bqMySd/
 ODeAx2p6aHDRpacx9iH71pZCCnoCx4Eb7sLEqs0uOR3sVgesohmTfJkLFH/srJDlzeWM
 s7Ztxa4anYgdq1L43HKQJrnvG7hxoWKT/gILfLJpFODeSgCESYT4lvV6uQ5J96rbSjsx
 PGmA==
X-Gm-Message-State: AOJu0YwFEkm9k2UlCcDlYAeRCiscjcxefH8x3Wn8xjN6yEbNlHqz35jO
 MF3dW7COkhjWpkJ0g309aWu6Yw/FJbfuUUQBzcqsnQclc6C14CCjAuqrR6nolBHVtYCRdussk3d
 A5djXt9E6AiC0pzA=
X-Received: by 2002:a05:6402:5d85:b0:52c:164:efe4 with SMTP id
 if5-20020a0564025d8500b0052c0164efe4mr1131894edb.34.1693392358959; 
 Wed, 30 Aug 2023 03:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkg3OaZwuj4d2os+pIhs1OULxRc542FvaeQ9kittX0ggLu4Ck2C4kQZr5B2c2Br4UPsCC8Fg==
X-Received: by 2002:a05:6402:5d85:b0:52c:164:efe4 with SMTP id
 if5-20020a0564025d8500b0052c0164efe4mr1131881edb.34.1693392358681; 
 Wed, 30 Aug 2023 03:45:58 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 d3-20020aa7d683000000b0051dfa2e30b2sm6657167edr.9.2023.08.30.03.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 03:45:57 -0700 (PDT)
Date: Wed, 30 Aug 2023 06:45:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Message-ID: <20230830064521-mutt-send-email-mst@kernel.org>
References: <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
 <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
 <20230829163929-mutt-send-email-mst@kernel.org>
 <fd3665ae-da56-9d86-ff91-b1efa107671b@linaro.org>
 <20230829164638-mutt-send-email-mst@kernel.org>
 <86c5e07d-58f0-41a0-f497-bd236691188b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86c5e07d-58f0-41a0-f497-bd236691188b@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 30, 2023 at 10:22:53AM +0200, Marcin Juszkiewicz wrote:
> W dniu 29.08.2023 o 22:46, Michael S. Tsirkin pisze:
> > On Tue, Aug 29, 2023 at 10:44:08PM +0200, Marcin Juszkiewicz wrote:
> > > W dniu 29.08.2023 o 22:40, Michael S. Tsirkin pisze:
> > > > > It passes with sbsa-ref (which is not using QEMU versioning).
> > > > > 
> > > > > Fails (as expected) when used new property for each pcie-root-port
> > > > > (ignore line breaks):
> > > > > 
> > > > > "-device pcie-root-port,
> > > > >     x-pci-express-writeable-slt-bug=true,
> > > > >     id=root30,chassis=30,slot=0"
> > > > 
> > > > could you also check with -machine pc-q35-8.1 instead of this
> > > > property?
> > > 
> > > BSA ACS is AArch64 only.
> > 
> > virt-8.1 then
> 
> Passes for virt, virt-8.1 and virt-8.0 machines.
> 
> ./code/qemu/build/aarch64-softmmu/qemu-system-aarch64 \
>  -machine virt-8.0 \
>  -m 4096  \
>  -cpu neoverse-n1 \
>  -smp 2 \
>  -drive if=pflash,format=raw,file=QEMU_EFI.fd \
>  -drive if=pflash,format=raw,file=QEMU_EFI-vars.fd \
> -drive file=fat:rw:$PWD/disks/virtual/,format=raw \
> -device pcie-root-port,id=root30,chassis=30,slot=0 \
> -device igb,bus=root30 \
>  -device qemu-xhci,id=usb \
>  -device bochs-display \
>  -device e1000e \
> -nographic \
>  -usb \
>  -device usb-kbd \
>  -device usb-tablet \
>  -monitor telnet::45454,server,nowait \
>  -serial stdio
> 


Weird. OK let me post it properly and you can then test and confirm
it fails on 8.1 and 8.0 and passes on latest.



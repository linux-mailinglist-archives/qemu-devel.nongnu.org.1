Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1881CCA0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 17:18:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGiCg-0005wF-7u; Fri, 22 Dec 2023 11:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGiCd-0005vx-C0
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGiCb-0005WV-Mu
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703261804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXq84KoxFB9NL5NQ+8gBUJdSP4q84N3VHp8bEcuLjFA=;
 b=HrqhoxCb5rxOfYiIChFdRnpQd7EhaVeyIO+d7lcpYHFK9zWQR0UirIlxboHgg0iJz9eFDn
 MaF6GpauJzxbxD+1dYc+SHu24ru4Vt7t0SwZUnyWOrTeHqv05HQCsBNTETZTIIXSfNekOV
 AbmGSTitXH6Smg5ycJhxVm6JjjdW8MY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-PYFuY1LzN4OiX0elDXNYAw-1; Fri, 22 Dec 2023 11:16:42 -0500
X-MC-Unique: PYFuY1LzN4OiX0elDXNYAw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bb90fa2a7bso364736b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 08:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703261802; x=1703866602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JXq84KoxFB9NL5NQ+8gBUJdSP4q84N3VHp8bEcuLjFA=;
 b=Me2Nar3N9YqPmwYbznDRVgvlmkr4KsMHVDM1vih7Jc0vPY0Q07eMZxNs42JJPx8mcV
 TFqmSi8qhpKtDrqhM22HT90S4wn5/cdHV65GQrUWemHu3HTB4CI6XspG9bMXQkT/5Nkz
 68wk58rgDP90h/+suJF55XaZEtrpH8DrdyoYNHsurCN65sVwF5ZsGzBRf7bspUvBjAX6
 IBR9eksU3B+yBZDIFTFA7fRa7ZYfuwi3FXQZKKCxIrNoNDN/+mZQxyG5SI+XiQ5QH6OT
 8lMeEwBqIRco787tqGCe1g2mDHypYm+l3yiixuZjKs0NNl2EkNKvjm1LI1GnjWpnlMNs
 x7cQ==
X-Gm-Message-State: AOJu0Ywm+31CmahZVQzmjvOb9BPVt6JjI4+f+0wghsx1mnopjY0iokLl
 bH+re2B0dqbHGU8n7hY+nQTt/8SxrhX92MQXKFWfwRf5FE58cLMcjINKGZWanFyeg8u2aqGMK0x
 31iigCn60d8Af2xHtWvEMElmpnO2H7sjQKzXNveM=
X-Received: by 2002:a05:6808:3990:b0:3b9:cdbf:c789 with SMTP id
 gq16-20020a056808399000b003b9cdbfc789mr2624038oib.60.1703261802087; 
 Fri, 22 Dec 2023 08:16:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX27B9a+jaDuQJs3iUbbdetKzCIPtmwQQ4O1a1yHhNgqZEKF9TWeWjcONI2TyBtlzhtgMFP+X68y6SR3MPqZY=
X-Received: by 2002:a05:6808:3990:b0:3b9:cdbf:c789 with SMTP id
 gq16-20020a056808399000b003b9cdbfc789mr2624027oib.60.1703261801822; Fri, 22
 Dec 2023 08:16:41 -0800 (PST)
MIME-Version: 1.0
References: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
 <1082dfde-644b-4887-bd0f-35b8cea6be26@linaro.org>
 <CABgObfY=Rd5fih1=2y17ACoeqsPOKUynwOnpL+ygvk5Xis5pNw@mail.gmail.com>
In-Reply-To: <CABgObfY=Rd5fih1=2y17ACoeqsPOKUynwOnpL+ygvk5Xis5pNw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Dec 2023 17:16:29 +0100
Message-ID: <CABgObfaJyMd-gqZYVdNkjFXhdxX81REMA324vwBiqTEswMAvwg@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Fix physical address truncation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 22, 2023 at 10:04=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> > If the extension is not needed, then the a20 mask isn't either.
>
> I think it is. The extension is not needed because the masking is
> applied by either TCG (e.g. in gen_lea_v_seg_dest or gen_add_A0_im) or
> mmu_translate(); but the a20 mask is never applied elsewhere for
> either non-paging mode or page table walks.

Hmm, except helpers do not apply the masking. :/

So Michael's patch would for example break something as silly as a
BOUND, FSAVE or XSAVE operation invoked around the 4GB boundary.

The easiest way to proceed is to introduce a new MMU index
MMU_PTW_IDX, which is the same as MMU_PHYS_IDX except it does not mask
32-bit addresses. Any objections?

Paolo



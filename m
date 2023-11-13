Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A87EA252
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:48:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b2n-0001tB-CN; Mon, 13 Nov 2023 12:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2b2j-0001m0-1P
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:48:13 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2b2h-0003bv-Fh
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:48:12 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-778927f2dd3so239049185a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897690; x=1700502490; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R7gzuZMyaAX07avLNluk1XFBv4yqThnwWrvQa7RjD1k=;
 b=AF+gwx18Sqm7SJCBMqc/0oISiztiN+vJq6cbRy4mzCFBVLqBulXprs63CV1NBCd3sk
 JwvqGxytC5397lvI8fdlbE6EmrViU57RxrdQ9yz7OtjvCNmbCIdpSwNq+zpSdVBuevRC
 lpD/YmPL3nYoRj67xDiKR7oZ3a4gU6bMKQgvjcVvP3hmBnkObk/eGysjtgPmfetmkOYp
 jzWTKT9w5a68YfnlP2kzcfFUq1S0SbN3bwY4P4VMlPJXhzMa4/Ghu0yTvrIHB9+c+5pW
 Vh20SkQYpge+Uaj7qeyE4AcoTYpKNluJpMBuZsunhINdv7FCsDmJxnl8v9g8m7j9lcgp
 VKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897690; x=1700502490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7gzuZMyaAX07avLNluk1XFBv4yqThnwWrvQa7RjD1k=;
 b=beY6CRdM5DesHfGqUHMG2xq3/bWczR9hcshfiyFihkrOjazNDPW0LVlSeBWrrBeoiO
 Km82dUoUpq2BItyzbTOAtdXQVfMxtPL6OY4UAKX/SiAXAAY1KnFZl8K8vu8ulDO4fM23
 wkgWBqRNqwveehr4qCYOT6Bl1cJbki9cajGKJVD5SMEr0vxH3cAvyKuTY9hZ4mzbb810
 qHzcsC1K/1N/a2NKfQpfR86bG95PMD9gsVCzknB9GavVNi0I6GZu+E8y15+D1ahuk3/Q
 K31m+N0qT18E6VHremggq5lS/I9FwQ4srr76gjRCmdNjzzj31aG0NDMzSbuTnNzuTAKL
 eqjQ==
X-Gm-Message-State: AOJu0Yyg3PNFIh+5iWK8H9JDXk7YyTwkcEItuSQvNdHpdVc46jzn7ZO6
 HjqqwyuuGYboPexjIRXD1NxyoA==
X-Google-Smtp-Source: AGHT+IGpzK9IEbSnSP/swyL4ue6rtWrNpI4Jbm79foM+PHKkE44a5nMss0i2FiUA1xV+EwtsPs+23g==
X-Received: by 2002:a05:620a:3955:b0:777:7178:ebf2 with SMTP id
 qs21-20020a05620a395500b007777178ebf2mr5832166qkn.18.1699897689994; 
 Mon, 13 Nov 2023 09:48:09 -0800 (PST)
Received: from leoy-huanghe ([12.186.190.1]) by smtp.gmail.com with ESMTPSA id
 h27-20020a05620a21db00b00767dba7a4d3sm2027806qka.109.2023.11.13.09.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:48:09 -0800 (PST)
Date: Tue, 14 Nov 2023 01:48:08 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v1 3/4] hw/virtio: Move vhost-user-input into virtio folder
Message-ID: <20231113174808.GA58963@leoy-huanghe>
References: <20231113011642.48176-1-leo.yan@linaro.org>
 <20231113011642.48176-4-leo.yan@linaro.org>
 <41wpa.smmzo0kr8q76@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41wpa.smmzo0kr8q76@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=leo.yan@linaro.org; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Manos,

On Mon, Nov 13, 2023 at 09:24:09AM +0200, Manos Pitsidianakis wrote:
> Hello Leo,
> 
> On Mon, 13 Nov 2023 03:16, Leo Yan <leo.yan@linaro.org> wrote:
> > vhost-user-input is in the input folder.  On the other hand, the folder
> > 'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).
> > 
> > This patch moves vhost-user-input into the virtio folder for better code
> > organization.  No functionality change.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Make sure MAINTAINERS is updated as well, it points to hw/input:

You are right, will update in next spin.

Thanks for pointing out this and review!

Leo


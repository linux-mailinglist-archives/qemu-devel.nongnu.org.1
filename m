Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8B7EA345
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:06:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cFw-0006Xb-5d; Mon, 13 Nov 2023 14:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cFj-0006U8-5F
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:05:45 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cFc-0000st-Fk
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:05:37 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41e3e77e675so31310061cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902335; x=1700507135; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OpaeiBvhn9XWKK7ldJ1Yp97BtwVlsLFr3N4dEk0Y+94=;
 b=DGTgWIULs6hsWoHx+rw6yCHoQ5rmtxfdAsfZhPdRn830sPowKWtyGwe4NaT6xTbI/2
 3pt8kl9bhkBKIuIHr7JDfn8lnsSCKP1dBpxRIfK7UyEuz69hn1TI2asSZdUkVEmsUZnI
 P6Yft0mtjcjODuqt1Fn7iKmQfumBj9nO3P2jPe29PClatVwmhEr5JfSFyjS1A6xAJPDG
 BkojLYyVdFSo4vMlrIsw4xA8OIe8082dqW5z0sMagBhuvwlJEHPKly6rqks2VM57eR08
 iToasXnr8ds2uaN/AM0/vUO0s+q0Vul0Xz0hyRbUDH0e+N9JoIEuRxA0SF4pisQa4uCN
 jW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902335; x=1700507135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpaeiBvhn9XWKK7ldJ1Yp97BtwVlsLFr3N4dEk0Y+94=;
 b=j5GWbCSBFq8MMZTFGN3KocM8Rh3sA56753N4Dtr6QYTLxXITq028NMO1uCjCyUh3bP
 wjt6M03p9Vwgtppkt5Tky8t2L2PpQL/HTTrosGoex+caH4wQ0v3G8kiYq8A8/rbPgRSu
 Jzo7zRDfOQLun2TVEh2gXLHRkXa56peA29g8dhLjL96RxkCltRNnNeVsZt23PymO9579
 mF5+DI7rKQonZK3mLqNkadvPM+rGQKAJtl0u1VJ2USQ00MA5TCqkN0bV1wYmuVm2qPs0
 EzYVkeTC8xiVKJhA8vqwN23T1KT62XlE2EHRZtyuHKfP+pe9WFIOpwhOtrb2C7MmKtvc
 YRBQ==
X-Gm-Message-State: AOJu0YwHAxOod07Cx09iqpxSiRHW+AnJ4iGg7CbuEjuAIjDf0VHA+jRX
 mq7fiie2cOZOUMfDIOSNbXII2w==
X-Google-Smtp-Source: AGHT+IFUeTprAImyiGGkn7WmuRrD4GUB2z0YZs09zPr7uevlnrRQM9RiC5hfSlXcxlhlIHwPSjVqkg==
X-Received: by 2002:a05:6214:5ece:b0:66d:a20f:ecfb with SMTP id
 mn14-20020a0562145ece00b0066da20fecfbmr85198qvb.37.1699902334699; 
 Mon, 13 Nov 2023 11:05:34 -0800 (PST)
Received: from leoy-huanghe ([12.186.190.1]) by smtp.gmail.com with ESMTPSA id
 v11-20020ad4534b000000b006655cc8f872sm1978079qvs.99.2023.11.13.11.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:05:34 -0800 (PST)
Date: Tue, 14 Nov 2023 03:05:32 +0800
From: Leo Yan <leo.yan@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v1 0/4] virtio: Refactor vhost input stub
Message-ID: <20231113190532.GB58963@leoy-huanghe>
References: <20231113011642.48176-1-leo.yan@linaro.org>
 <20231113012849-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113012849-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x82f.google.com
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

Hi Michael,

On Mon, Nov 13, 2023 at 01:29:49AM -0500, Michael S. Tsirkin wrote:

[...]

> > The series is based on "[PATCH v8 0/7] virtio: cleanup
> > vhost-user-generic and reduce c&p" which introduces vhost-user-base.
> > Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>
> 
> 
> That patchset is deferred until after the release, so this one
> will be, too. I have tagged it, to help make sure it's not
> lost pls ping me after the release.

Just remind, I have sent v2.

And will monitor mailing list for the release.

Thanks,
Leo


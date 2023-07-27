Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0707658CA
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Uv-0006dX-T6; Thu, 27 Jul 2023 12:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3Ur-0006d7-9G
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:05:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3Up-0001vZ-Ro
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:05:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-314172bac25so1131728f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690473946; x=1691078746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4s3yjcZ2vRVHgzK6hn2+1/dhgBJOv42KtkzRrKRA6Jc=;
 b=g+qwjQkrRd6H8GH/yQtkVAeVg9zSeDcs1KDcsDXx1k+M9SsY6eoHLRfUeNfnNqqH6Y
 +LRGL9pQpZHkWagkFe6umI8b877GJKXD7Enf0zK+Poe51XHBuaL+sFsQDXTOvvVSBJNP
 4CQtVN7jO8huxd0k8NTXaC9X04HJk0NKMOC3So+kekUX/p3s7C6j02S4k9/J5F18pDl+
 vIjvPd15mYD6BTDNV9YfUVbCUL4sYjNA8gwMw/IE7c/ebyuXtyD3JU7B1e9wmoMJZ+Jq
 s5fsBRasNPgBLCJTJBXP1ZFWmfbTvOi2sBBhFsHbqOA3MAusmroyhrh2SBEw+2BVpqw+
 pSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690473946; x=1691078746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4s3yjcZ2vRVHgzK6hn2+1/dhgBJOv42KtkzRrKRA6Jc=;
 b=MKfqa3lmaatZTlgvmr+F+SJhIGVsFM4IONLZqRMCEOvtvJnyu+nPAUv5hFNellvK7q
 SHoiJfhV6kH1F/xrhneWzwTTPrnSkht790AcckK0g1O9xhHh7YKdN+20Nk1u7Qw/a2vu
 iuPZyQw5v+ptZ9TS1JS+mD3r+ioKauKqFOa/F8K58RExonvbaGEc9ZEIZ2VyEBV5qmjV
 6NvwPwbzgOb5XS390wDMpUmXwdn/nc/l862452oXZwt6utRH5pVPLOKAFsfL3pbBvK45
 a9KlE14MRGaTBQDFzyt9ujh6tzsLj0UPBU6ebY9Q3kJJCxYF973U2JNHoy2DGZI9mG7B
 Bjrw==
X-Gm-Message-State: ABy/qLYe3KTNfIr2H9fWZg62cRUb3eD00q0js1C7zMy9HPUU+4cyfT8s
 XSWE9hJ9vC9PsOP+k/gDUYcIvbvikL/VeTVBH8v98Q==
X-Google-Smtp-Source: APBJJlE9709XXSBw95bTFBAVUOJ8kzsLC6rlWxTrwbQNtOZ3x+aoM8aDqNhz5jf9yiSeaNc4m56RaLULYqhnZid9tZI=
X-Received: by 2002:a5d:420b:0:b0:314:3ad6:2327 with SMTP id
 n11-20020a5d420b000000b003143ad62327mr2259572wrq.12.1690473946033; Thu, 27
 Jul 2023 09:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230725150002.621-1-shameerali.kolothum.thodi@huawei.com>
 <CAFEAcA_3+=m8nt6_eJMiEpxyGcSAXJRC5LWMVvU3f9CHAxKzCw@mail.gmail.com>
In-Reply-To: <CAFEAcA_3+=m8nt6_eJMiEpxyGcSAXJRC5LWMVvU3f9CHAxKzCw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 17:05:34 +0100
Message-ID: <CAFEAcA8euHStuwCHVwWC=4=gE91gFrcz4o4sYQDy1X_RW5yv9g@mail.gmail.com>
Subject: Re: [RFC PATCH] arm/kvm: Enable support for
 KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, ricarkol@google.com, 
 kvm@vger.kernel.org, jonathan.cameron@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Thu, 27 Jul 2023 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 25 Jul 2023 at 16:01, Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com> wrote:
> > +static bool kvm_arm_eager_split_size_valid(uint64_t req_size, uint32_t sizes)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < sizeof(uint32_t) * BITS_PER_BYTE; i++) {
> > +        if (!(sizes & (1 << i))) {
> > +            continue;
> > +        }
> > +
> > +        if (req_size == (1 << i)) {
> > +            return true;
> > +        }
> > +    }
>
> We know req_size is a power of 2 here, so if you also explicitly
> rule out 0 then you can do
>      return sizes & (1 << ctz64(req_size));

Er, that's also over-complicated. Just
   return sizes & req_size;

should do (and catches the 0 case correctly again).

-- PMM


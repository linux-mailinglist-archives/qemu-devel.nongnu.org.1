Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9D7CF8FE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSBn-00023x-TE; Thu, 19 Oct 2023 08:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtSBP-0001rs-R4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:31:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtSBM-0006Rj-56
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:31:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso1603899a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697718676; x=1698323476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hyHjOLrvFMewnfFTD2xl3OUPurv+Xcb2TEDNwdOGU8=;
 b=VEMfQCrNinCdB9lgY653MW/drfhy5ubTsmFyyTA/Cb7tv2uZoYsBoub5PmjGPKwBZn
 JwbTtBkCFkVtM0zPvnmh3xMauO+IAx+V+aG/7PEDmJM8wBDvPltW/IK8BH2Ax5X8sl1Y
 B6SPV16apM9/Y0I/vnuWSGoX4yWzctunpZ8EGqfTy+bL9pP3r+KJqsNK9uFyn7C1dYjG
 ppgbfc8xfMTGj2bud2iiUViipciSmeHmxQ+z6UsQ5c+kdAKf7v6aGlzdn++HFqfD1CLd
 x21vmIvFX8TNbBOyFf5SvaYHigMb3s9QE0vM4mK3pj5IoxD5Ob8veN73fZLuQz6hZFek
 l0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697718676; x=1698323476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hyHjOLrvFMewnfFTD2xl3OUPurv+Xcb2TEDNwdOGU8=;
 b=LJB+ENSWwpdyqk7fCxDaFxvdtbMmCSvzB1k5HwHVwmiFc3KZUUTqU6rO9+jOSm13wE
 TEYlrwYYHJDtLyq2OHNm/isqn9LZMvccvoIY067hxIEQsJnKUZTxGpa5nHx+3NNOHLUk
 c0CJDYLh3npKhlBmFsxr7dude5r9zv38N+BAkxy5N0dewmhAZTVCFbnltnOG2BBE4T2u
 qKzXL+v5ls6Oyvt1gswaQ7o7bn/wmRWxIiDZinYaRfhpwHF1O3BM8HVfsT45fnZEzsWM
 TZNNG5tMgKGWZFmrBt9tLPTI3XPT08zRPgzAqDk3cnI7e+mE8N7vQTATaq2TGY1cxNMu
 L2Lw==
X-Gm-Message-State: AOJu0YyHszgCEkeMmUjFOdD5CjBopUTyfZfULyasN5HcXF7JTT4/q8CQ
 7npB5SrWHd3ZzKxzq2L0GbToASZgETql6ZvlcJHSmQ==
X-Google-Smtp-Source: AGHT+IF+oxqe92OAvsesmyMryOvRmgW7PKKChpMeO5kWR/D56N1UAR6ICb3UEBsLcoGx16WfT9iBQrhs1zDKB+09xdM=
X-Received: by 2002:a50:9f88:0:b0:533:ccec:552 with SMTP id
 c8-20020a509f88000000b00533ccec0552mr1638264edf.9.1697718676613; Thu, 19 Oct
 2023 05:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696477105.git.mst@redhat.com>
 <e967413fe0f2f3fe022658bb279aef95d24210ec.1696477105.git.mst@redhat.com>
In-Reply-To: <e967413fe0f2f3fe022658bb279aef95d24210ec.1696477105.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2023 13:31:05 +0100
Message-ID: <CAFEAcA9VQ8KBCT7+CbY-1so5KVDUfydwP=MEJfc+1rkddFaq4A@mail.gmail.com>
Subject: Re: [PULL v2 38/53] hw/cxl: Support 4 HDM decoders at all levels of
 topology
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 5 Oct 2023 at 04:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> and CXL Type 3 end points.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>



> -/* TODO: Support multiple HDM decoders and DPA skip */
>  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>  {
>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
>      uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> -    uint64_t decoder_base, decoder_size, hpa_offset;
> -    uint32_t hdm0_ctrl;
> -    int ig, iw;
> -    int i = 0;
> +    unsigned int hdm_count;
> +    uint32_t cap;
> +    uint64_t dpa_base = 0;
> +    int i;
>
> -    decoder_base =
> -        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);
> -    if ((uint64_t)host_addr < decoder_base) {
> -        return false;
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                 CXL_HDM_DECODER_CAPABILITY,
> +                                                 DECODER_COUNT));
> +
> +    for (i = 0; i < hdm_count; i++) {
> +        uint64_t decoder_base, decoder_size, hpa_offset, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int ig, iw;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
> +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
> +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * hdm_inc);
> +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base += skip;
> +
> +        hpa_offset = (uint64_t)host_addr - decoder_base;
> +
> +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
> +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            return false;
> +        }
> +        if (((uint64_t)host_addr < decoder_base) ||
> +            (hpa_offset >= decoder_size)) {
> +            dpa_base += decoder_size /
> +                cxl_interleave_ways_dec(iw, &error_fatal);

I noticed this because of a Coverity false-positive, but should
this really be using error_fatal? It looks like a guest program
writing bogus values to registers could trip this, and generally
we don't like to let the guest make QEMU exit.

thanks
-- PMM


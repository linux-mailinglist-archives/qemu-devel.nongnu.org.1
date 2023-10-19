Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BBE7CFBF8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTdW-00079o-VA; Thu, 19 Oct 2023 10:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qtTdU-00072O-0r
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:04:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qtTdR-0008F5-3G
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:04:27 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB8WX2TZHz6HJdv;
 Thu, 19 Oct 2023 22:00:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 15:04:21 +0100
Date: Thu, 19 Oct 2023 15:04:19 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PULL v2 38/53] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20231019150419.00001a9a@Huawei.com>
In-Reply-To: <CAFEAcA9VQ8KBCT7+CbY-1so5KVDUfydwP=MEJfc+1rkddFaq4A@mail.gmail.com>
References: <cover.1696477105.git.mst@redhat.com>
 <e967413fe0f2f3fe022658bb279aef95d24210ec.1696477105.git.mst@redhat.com>
 <CAFEAcA9VQ8KBCT7+CbY-1so5KVDUfydwP=MEJfc+1rkddFaq4A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 19 Oct 2023 13:31:05 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 5 Oct 2023 at 04:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >  
> 
> 
> 
> > -/* TODO: Support multiple HDM decoders and DPA skip */
> >  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> >  {
> >      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> >      uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> > -    uint64_t decoder_base, decoder_size, hpa_offset;
> > -    uint32_t hdm0_ctrl;
> > -    int ig, iw;
> > -    int i = 0;
> > +    unsigned int hdm_count;
> > +    uint32_t cap;
> > +    uint64_t dpa_base = 0;
> > +    int i;
> >
> > -    decoder_base =
> > -        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
> > -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);
> > -    if ((uint64_t)host_addr < decoder_base) {
> > -        return false;
> > +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> > +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> > +                                                 CXL_HDM_DECODER_CAPABILITY,
> > +                                                 DECODER_COUNT));
> > +
> > +    for (i = 0; i < hdm_count; i++) {
> > +        uint64_t decoder_base, decoder_size, hpa_offset, skip;
> > +        uint32_t hdm_ctrl, low, high;
> > +        int ig, iw;
> > +
> > +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
> > +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
> > +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> > +
> > +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
> > +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
> > +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> > +
> > +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> > +                       i * hdm_inc);
> > +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> > +                        i * hdm_inc);
> > +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> > +        dpa_base += skip;
> > +
> > +        hpa_offset = (uint64_t)host_addr - decoder_base;
> > +
> > +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
> > +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> > +        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> > +        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> > +            return false;
> > +        }
> > +        if (((uint64_t)host_addr < decoder_base) ||
> > +            (hpa_offset >= decoder_size)) {
> > +            dpa_base += decoder_size /
> > +                cxl_interleave_ways_dec(iw, &error_fatal);  
> 
> I noticed this because of a Coverity false-positive, but should
> this really be using error_fatal? It looks like a guest program
> writing bogus values to registers could trip this, and generally
> we don't like to let the guest make QEMU exit.

I have on my list adding a bunch of verification to the HDM decoder
commit path that will make this harder to hit, but in theory not prevent
it unless we make a decision to paper over the problem. I'll aim to do
that sooner rather than later.

Changing this after commit is specifically called out as 'undefined behavior' 
8.2.4.19.13
"Reprogramming the decoder while the Commit bit is set results in undefined
behavior".  We should probably choose the behavior to not be fatal but we do
want to scream very very loudly if a guest does this as it indicates something
that may well bring down a real system.

I get your point on not letting a guest do nasty things though so perhaps
we should user error_warn instead?

Making it die here was deliberate as I really really want to know if someone
hits it and they tend to tell me if QEMU quits on them.
I take your point though about it not being a good idea when looking at
it from a broader point of view!

Jonathan


> 
> thanks
> -- PMM
> 



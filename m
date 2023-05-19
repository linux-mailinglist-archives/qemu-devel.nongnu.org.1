Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F522709699
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzyN5-0005RK-HU; Fri, 19 May 2023 07:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzyN0-0005R3-Va
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:34:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzyMy-0007Yd-Ix
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:34:02 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN4PW0RvTz6J76p;
 Fri, 19 May 2023 19:29:35 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 12:33:54 +0100
Date: Fri, 19 May 2023 12:33:53 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Michael
 Roth <michael.roth@amd.com>, Philippe =?ISO-8859-1?Q?Mathieu-Da?=
 =?ISO-8859-1?Q?ud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 3/6] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230519123353.00004a00@huawei.com>
In-Reply-To: <20230423162013.4535-4-Jonathan.Cameron@huawei.com>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
 <20230423162013.4535-4-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, 23 Apr 2023 17:20:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This doesn't work for s390 (probably big endian hosts in general)

I'll post a new version of the series with adjusted logic shortly. 
I think all we can do is special case the 24 bit logic in the block
dealing with big vs little endian accessors.

Something like the following.
I'll drop Fan's tag as this is a substantial change. Fan, if you can
take a look at v6 when I post it that would be great.

I'm having issues with gitlab CI minutes running out on my fork.
Hopefully I can get that resolved and test this properly. 

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 91ed9c7e2c..f546b1fc06 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -40,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
 #define be_bswaps(p, size) \
@@ -319,7 +321,7 @@ static inline void stw_le_p(void *ptr, uint16_t v)

 static inline void st24_le_p(void *ptr, uint32_t v)
 {
-    st24_he_p(ptr, le_bswap(v, 24));
+    st24_he_p(ptr, le_bswap24(v));
 }

 static inline void stl_le_p(void *ptr, uint32_t v)

> 
> ---
> v5:
>   - Added assertion that upper bits of the input parameter aren't set.
>   - Mask value in bswap24s()
>   - update docs
> ---
>  docs/devel/loads-stores.rst |  1 +
>  include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index ad5dfe133e..57b4396f7a 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>  ``size``
>   - ``b`` : 8 bits
>   - ``w`` : 16 bits
> + - ``24`` : 24 bits
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
>  
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 15a78c0db5..91ed9c7e2c 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,11 +8,25 @@
>  #undef  bswap64
>  #define bswap64(_x) __builtin_bswap64(_x)
>  
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    assert((x & 0xff000000U) == 0);
> +
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>  static inline void bswap16s(uint16_t *s)
>  {
>      *s = __builtin_bswap16(*s);
>  }
>  
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s & 0x00ffffffU);
> +}
> +
>  static inline void bswap32s(uint32_t *s)
>  {
>      *s = __builtin_bswap32(*s);
> @@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
>   * size is:
>   *   b: 8 bits
>   *   w: 16 bits
> + *   24: 24 bits
>   *   l: 32 bits
>   *   q: 64 bits
>   *
> @@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>      __builtin_memcpy(ptr, &v, sizeof(v));
>  }
>  
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>  static inline int ldl_he_p(const void *ptr)
>  {
>      int32_t r;
> @@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>      stw_he_p(ptr, le_bswap(v, 16));
>  }
>  
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap(v, 24));
> +}
> +
>  static inline void stl_le_p(void *ptr, uint32_t v)
>  {
>      stl_he_p(ptr, le_bswap(v, 32));



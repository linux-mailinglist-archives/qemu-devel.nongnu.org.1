Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82112AB9FB6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 May 2025 17:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwpH-0003Wj-S7; Fri, 16 May 2025 11:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uFwpE-0003WV-Th
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:18:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uFwpA-0005tZ-Jj
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:18:16 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250516151802epoutp015c395f1ff782341cf457de6c00eee46e~ACvBULHiA1773617736epoutp016
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 15:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250516151802epoutp015c395f1ff782341cf457de6c00eee46e~ACvBULHiA1773617736epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1747408682;
 bh=E85jH9QVUT8P1LixCP1oAw2UkkMmunHr38TMOzcPBos=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PpCBOWNdd9DYVDUebzy+43LjztbGNkNTt2YHVUwcx9cigVIjBEwbESCwZKcVfTPoX
 qC1q1aITRQVbb4eHBT+bF6AUU5vOhbyuJNsdbYbN7Xc9cK/6244QC0KKKOij81xTtU
 fvUV6cWcZ4k5MSYu8dWu2jYvvKG+7u8wwCdWk1sY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20250516151802epcas5p4bd733167b2f5cdbd7650f1fd06f9f28a~ACvA5AbHY1869018690epcas5p4T;
 Fri, 16 May 2025 15:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4ZzW161fQKz3hhT4; Fri, 16 May
 2025 15:18:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043~ABb_QgPGr3219832198epcas5p37;
 Fri, 16 May 2025 13:42:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250516134255epsmtrp1b18e61f9cb0486ce2d5e587b50cd9d19~ABb_PkAqp3082530825epsmtrp1D;
 Fri, 16 May 2025 13:42:55 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-b6-682740df1c17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 49.F4.07818.FD047286; Fri, 16 May 2025 22:42:55 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250516134253epsmtip1b55d92dcfa4f0774945cd0fcb7f5f6eb~ABb8j0Xri0866808668epsmtip1i;
 Fri, 16 May 2025 13:42:53 +0000 (GMT)
Date: Fri, 16 May 2025 19:12:45 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org, linuxarm@huawei.com, fan.ni@samsung.com, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Sweta Kumari <s5.kumari@samsung.com>,
 Vinayak Holikatti <vinayak.kh@samsung.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>, cpgs@samsung.com
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for
 Get Log Capabilities (Opcode 0402h)
Message-ID: <1983025922.01747408682214.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20250512174038.00000beb@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO59B/UMgzczVS0e/57FZvHykKbF
 6ptrGC2aVt9ltVi18BqbxflZp1gsDm88w2Tx/9crVovjvTtYLNac+8xiceLkdnaLadOesDnw
 eLQcecvq8X19B5vHk2ubmTy2z5rK6PF+31U2j74tqxg9ps6u9/i8SS6AI4rLJiU1J7MstUjf
 LoEr4//6FpaCn54Vu3tVGhhfm3UxcnJICJhIHPrzmbWLkYtDSGA3o8SJDVvZIBIyEhdnPmaB
 sIUlVv57zg5R9IFRYtaCbewgCRYBVYkPF3aygthsAjoS52/PBWsWETCSeHdjEiNIA7PAGyaJ
 7yd2g00SFsiXuLfoFiOIzSvgLLFo6yZmiKktTBIv3j9mhUgISpyc+QSsgVnATGLe5odARRxA
 trTE8n8cEGF5ieats5lBbE4BQ4nX266zT2AUnIWkexaS7lkI3bOQdC9gZFnFKJlaUJybnpts
 WGCYl1quV5yYW1yal66XnJ+7iREcaVoaOxjffWvSP8TIxMF4iFGCg1lJhPd6lnKGEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd6VhhHpQgLpiSWp2ampBalFMFkmDk6pBibNcxoCLNovgu8vOyo8
 5838uQqZWtMLbl4653V62h1uXefl6UU5ZUGMO0qX7riSvOLD7eRZj569ZgzQUMoQPH080u8v
 f4vd7JtvMy8fnFbEV2siaCJ1g22KM+Oklrv7/GOMFQM+zE9/vserVvzCs913/plPjer3r+/I
 ED2n5mNie1sz0XVW8Z+vrYE/N9S8ffh47+8/DgfPzgxoMg9wFe5Xj/w1e33Yz7l/NVhOCjbG
 Kpyomdq682r3hAjr5+t6qpYt+5v507lje4ZHkKz3DuOXnp+3znO6Jjz/ecOxmR7azFoPYvl7
 juVH3VS7ImnaHSCmNyHjp8uE8xf8Wl8vsJS9uvysrK06r6ODRf7CPmMlluKMREMt5qLiRABS
 noagIwMAAA==
X-CMS-MailID: 20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----liPob05VKUD2vc8xVCOoWv2_x95Q7t6uLYTZYYRHPtKjIUQA=_2405e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
 <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
 <20250512043011-mutt-send-email-mst@kernel.org>
 <20250512093638-mutt-send-email-mst@kernel.org>
 <20250512174038.00000beb@huawei.com>
 <CGME20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

------liPob05VKUD2vc8xVCOoWv2_x95Q7t6uLYTZYYRHPtKjIUQA=_2405e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 12/05/25 05:40PM, Jonathan Cameron wrote:
>On Mon, 12 May 2025 09:37:07 -0400
>"Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, May 12, 2025 at 04:42:41AM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
>> > > From: Arpit Kumar <arpit1.kumar@samsung.com>
>> > >
>> > > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
>> > > It provides log capabilities supported by specified log.
>> > >
>> > > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > > ---
>> > >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
>> > >  include/hw/cxl/cxl_mailbox.h |  5 ++++
>> > >  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
>> > >  3 files changed, 70 insertions(+)
>> > >
>> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> > > index ed6cd50c67..87a376c982 100644
>> > > --- a/include/hw/cxl/cxl_device.h
>> > > +++ b/include/hw/cxl/cxl_device.h
>> > > @@ -133,6 +133,18 @@ typedef enum {
>> > >      CXL_MBOX_MAX = 0x20
>> > >  } CXLRetCode;
>> > >
>> > > +/* types of logs */
>> > > +typedef enum {
>> > > +    CXL_LOG_COMMAND_EFFECT,
>> > > +    CXL_LOG_VENDOR_DEBUG,
>> > > +    CXL_LOG_COMPONENT_STATE_DUMP,
>> > > +    CXL_LOG_ERROR_CHECK_SCRUB,
>> > > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
>> > > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
>> > > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
>> > > +    MAX_LOG_TYPE
>> > > +} CXLLogType;
>> > > +
>> > >  typedef struct CXLCCI CXLCCI;
>> > >  typedef struct cxl_device_state CXLDeviceState;
>> > >  struct cxl_cmd;
>> > > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
>> > >      QSIMPLEQ_HEAD(, CXLEvent) events;
>> > >  } CXLEventLog;
>> > >
>> > > +typedef struct CXLLogCapabilities {
>> > > +    uint32_t param_flags;
>> > > +    QemuUUID uuid;
>> > > +} CXLLogCapabilities;
>> > > +
>> > >  typedef struct CXLCCI {
>> > >      struct cxl_cmd cxl_cmd_set[256][256];
>> > >      struct cel_log {
>> > > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
>> > >      } cel_log[1 << 16];
>> > >      size_t cel_size;
>> > >
>> > > +    /* get log capabilities */
>> > > +    const CXLLogCapabilities *supported_log_cap;
>> > > +
>> > >      /* background command handling (times in ms) */
>> > >      struct {
>> > >          uint16_t opcode;
>> > > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>> > > index 9008402d1c..8e1c7c5f15 100644
>> > > --- a/include/hw/cxl/cxl_mailbox.h
>> > > +++ b/include/hw/cxl/cxl_mailbox.h
>> > > @@ -16,4 +16,9 @@
>> > >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>> > >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>> > >
>> > > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>> > > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
>> > > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
>> > > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
>> > > +
>> > >  #endif
>> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> > > index 299f232f26..f35fc4f112 100644
>> > > --- a/hw/cxl/cxl-mailbox-utils.c
>> > > +++ b/hw/cxl/cxl-mailbox-utils.c
>> > > @@ -81,6 +81,7 @@ enum {
>> > >      LOGS        = 0x04,
>> > >          #define GET_SUPPORTED 0x0
>> > >          #define GET_LOG       0x1
>> > > +        #define GET_LOG_CAPABILITIES   0x2
>> > >      FEATURES    = 0x05,
>> > >          #define GET_SUPPORTED 0x0
>> > >          #define GET_FEATURE   0x1
>> > > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>> > >      return CXL_MBOX_SUCCESS;
>> > >  }
>> > >
>> > > +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
>> > > +{
>> > > +    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
>> > > +        if (qemu_uuid_is_equal(uuid,
>> > > +            &cci->supported_log_cap[i].uuid)) {
>> > > +                return &cci->supported_log_cap[i];
>> > > +        }
>> > > +    }
>> > > +    return NULL;
>> > > +}
>> > > +
>> > > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
>> > > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
>> > > +                                                uint8_t *payload_in,
>> > > +                                                size_t len_in,
>> > > +                                                uint8_t *payload_out,
>> > > +                                                size_t *len_out,
>> > > +                                                CXLCCI *cci)
>> > > +{
>> > > +    const CXLLogCapabilities *cap;
>> > > +    struct {
>> > > +        QemuUUID uuid;
>> > > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
>> > > +
>> > > +    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
>> > > +
>> > > +    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
>> > > +    if (!cap) {
>> > > +        return CXL_MBOX_INVALID_LOG;
>> > > +    }
>> > > +
>> > > +    memcpy(get_log_capabilities_out, &cap->param_flags,
>> > > +           sizeof(cap->param_flags));
>> > > +    *len_out = sizeof(*get_log_capabilities_out);
>> > > +    return CXL_MBOX_SUCCESS;
>> > > +}
>> > > +
>> > >  /* CXL r3.1 section 8.2.9.6: Features */
>> > >  /*
>> > >   * Get Supported Features output payload
>> > > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>> > >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>> > >                                0, 0 },
>> > >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>> > > +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
>> > > +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>> > >      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>> > >                                    cmd_features_get_supported, 0x8, 0 },
>> > >      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>> > > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>> > >      }
>> > >  }
>> > >
>> > > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>> > > +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> > > +};
>> > > +
>> >
>> >
>> > causes ci build failures:
>> >
>> > https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
>> >
>> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not constant
>> >      [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> >                                                             ^~~~~~~~
>> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for ‘cxl_get_log_cap[0].uuid’)
>> >
>> >
>> > Fixed it up like this:
>> >
>> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> > index f35fc4f112..13d26e391b 100644
>> > --- a/hw/cxl/cxl-mailbox-utils.c
>> > +++ b/hw/cxl/cxl-mailbox-utils.c
>> > @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
>> >  }
>> >
>> >  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
>> > -static const QemuUUID cel_uuid = {
>> > -    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
>> > +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
>> >                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
>> > +static const QemuUUID cel_uuid = {
>> > +    .data = CEL_UUID
>> >  };
>> >
>> >  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
>> > @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>> >  }
>> >
>> >  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>> > -    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> > +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = CEL_UUID },
>> >  };
>> >
>> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>> >
>>
>>
>> Actually no, does not help either. Dropped for now.
>> Next patch does not depend on this one, right?
>
>Indeed. Unrelated.
>
>Thanks,
>
>J

Thanks for pointing this out. The code builds successfully on my setup
with gcc version: 11.4.0. However, it fails to compile on gcc 7.5.0
"cc (SUSE Linux) 7.5.0" as used by Michael. This could be a compiler
issue as per the link:
https://stackoverflow.com/questions/54135942/why-initializer-
element-is-not-a-constant-is-not-working-anymore.

My setup doesn't allow me to regenerate the error using lower version
of compiler. A probable fix to it would be
type casting cel_uuid as: [CXL_LOG_COMMAND_EFFECT] =
{ .param_flags = 0,.uuid = (QemuUUID)cel_uuid }. It will be helpful
if you could test the same.

Also, In the existing code,
function: cmd_logs_get_supported(), cel_uuid(const) is assigned to a
non-const variable but I am unsure of why it is not throwing an error.

Thanks,
Arpit
>>
>> > >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>> > >  {
>> > >      cci->payload_max = payload_max;
>> > >      cxl_rebuild_cel(cci);
>> > > +    cci->supported_log_cap = cxl_get_log_cap;
>> > >
>> > >      cci->bg.complete_pct = 0;
>> > >      cci->bg.starttime = 0;
>> > > --
>> > > 2.43.0
>>
>>
>

------liPob05VKUD2vc8xVCOoWv2_x95Q7t6uLYTZYYRHPtKjIUQA=_2405e_
Content-Type: text/plain; charset="utf-8"


------liPob05VKUD2vc8xVCOoWv2_x95Q7t6uLYTZYYRHPtKjIUQA=_2405e_--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91553A30D6C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 14:56:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqjT-0005Lk-VM; Tue, 11 Feb 2025 08:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1thpI5-0003u9-Au
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:23:01 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s5.kumari@samsung.com>)
 id 1thpI2-00067B-Gy
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:23:01 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250211122253epoutp01faead4f07bfc380523f58b2ba6fb70ec~jJtQLzJdE0548605486epoutp01K
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250211122253epoutp01faead4f07bfc380523f58b2ba6fb70ec~jJtQLzJdE0548605486epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739276573;
 bh=P51UcJLPaMwD6C2GoxB0DdBlX7NquJQefHRN98xks54=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tfhpuUK5bCEDzvajWTI37ENsrBy8SIirzSKBF1xCuLhoWsW0axqSWT4fFnDcnohea
 +6yix9o8IwDvorfD3klCCIa79u0MI9R3YuBPf/ZPNezQ6gUXrNOlKiVOtMiBcsMx05
 FzABXH6ZIeRGMFiJVUUEWz/L+zRels988kTZBkEw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20250211122252epcas5p3936e8fe04379d006723191ef0cdc39c9~jJtPx-ctF0628306283epcas5p3_;
 Tue, 11 Feb 2025 12:22:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YsgZM434fz4x9Pt; Tue, 11 Feb
 2025 12:22:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 36.8C.20052.B114BA76; Tue, 11 Feb 2025 21:22:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250211113504epcas5p1bf475ef119b45766066b492d2a7684c1~jJDgHM1js0121101211epcas5p1g;
 Tue, 11 Feb 2025 11:35:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250211113504epsmtrp10a0172121dd9983e781c64b4e3edb124~jJDgGgN4Y0260202602epsmtrp1c;
 Tue, 11 Feb 2025 11:35:04 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-a9-67ab411b70b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 04.24.33707.7E53BA76; Tue, 11 Feb 2025 20:35:04 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250211113502epsmtip2c702228f8eca5d2bbfb4b3a5ccba9bfc~jJDecMnND0905509055epsmtip2R;
 Tue, 11 Feb 2025 11:35:02 +0000 (GMT)
Date: Tue, 11 Feb 2025 17:04:57 +0530
From: Sweta Kumari <s5.kumari@samsung.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 1/1] Added support for get/set alert configuration commands
Message-ID: <20250211113457.trn26pkbbg26b5gi@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <Z6JOfy74ujK6r_UB@smc-140338-bm01>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmlq604+p0gx3L5SymH1a0+HJ6D5vF
 6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFiB3DrsDp8fOWXfZPZ5c28zk0bdlFaPH
 1Nn1Hp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
 6Lpl5gCdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
 MjQwMDIFKkzIzmh5WFVw1aNi34sOxgbGXyZdjBwcEgImEjcPM3YxcnIICexmlPj1WwrC/sQo
 cfdXRRcjF4Td3H2SBSQBUr+l+wM7RNFORone2cpwRUd+XWAFSbAIqErsu3EGbCqbgJbEj88P
 mEFsEQEFic5r5xhBGpgFjjBKXGk/ApYQFgiUeNn3FqyBV8BZ4v21x+wQtqDEyZlPwDZzCuhL
 fF54jRWkWULgI7tE/+Ln7BAnuUisO/eGFcIWlnh1fAtUXEriZX8blJ0tcXdrJxuEXSLx4fZu
 JgjbXqL1VD/YEcwCGRLdN2ZD1ctKTD21jgkizifR+/sJVD2vxI55MLayxJZ/y6H2Skqs+LwE
 yvaQmPm0mQkSLE8YJWbd2cQ6gVFuFpKHZiHZB2FbSXR+aGKdBYwSZgFpieX/OCBMTYn1u/QX
 MLKuYpRMLSjOTU8tNi0wzEsth0dxcn7uJkZw+tTy3MF498EHvUOMTByMhxglOJiVRHhNFq5I
 F+JNSaysSi3Kjy8qzUktPsRoCoyhicxSosn5wASeVxJvaGJpYGJmZmZiaWxmqCTO27yzJV1I
 ID2xJDU7NbUgtQimj4mDU6qBSWdr+Ktkvz8tbacWtE8It5HRVbZbHhE+/8dPzw05BS8udhvf
 lq68mp9l9S93zdkA1q4Pv0y3XFnMJtEzJ/t278HuzyWcV26p7eueUr3EdW3PxtdbpELdGZnW
 eKlz7DqR2yq+7Jl7/ifJjy83pCjva47vTJFz3fCkf8HDicYL+FLL/168sCPph+aqSVNPv7kV
 0ugcce/r/ieuc4r3mTzcs3L2FZ1rfwUden5UlB/4bBg80VViT9XOHcvras6U/zSd68LruFqD
 9RRXsMiHxmlLj5yce3p/wbTcrnvnLrCELHx0cVfnJ5EnLwoY3wm6aF1Z33AqtcLC8oPxnnS3
 CWKLm/x+PcnOzvzpeP1f3Drp3VlKLMUZiYZazEXFiQBHE6GNKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO4L09XpBjO2MltMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLEDuHHYHTo+ds+6yezy5tpnJo2/LKkaP
 qbPrPT5vkgtgjeKySUnNySxLLdK3S+DK2NQ7k62g3a1i4zbxBsZjRl2MnBwSAiYSW7o/sHcx
 cnEICWxnlNg+eT4TREJS4u2ZS4wQtrDEyn/PoYo+MErc+9XCApJgEVCV2HfjDFgRm4CWxI/P
 D5hBbBEBBYnOa+cYQRqYBY4wSlxpPwKWEBYIlHjZ9xasgVfAWeL9tcdQU58wSszZv5sdIiEo
 cXLmE7ANzAJmEvM2PwRq5gCypSWW/+MACXMK6Et8XniNdQKjwCwkHbOQdMxC6FjAyLyKUTS1
 oDg3PTe5wFCvODG3uDQvXS85P3cTIzjotYJ2MC5b/1fvECMTB+MhRgkOZiURXpOFK9KFeFMS
 K6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamDal275jCHT6U3/x
 0z9/ljN3rlcURrQdN7kxhfmYC5d7wf7epQ1nF8ZlHVC8Eqx0KMl7f1hKpNCdr5xiU817v+Zy
 uvE+5gjfZ9mYnv47dv7Pfdwbfn6wrO5UvDpZOuFbeMn0Owlcx/9KXGMyjo2JmLw5/Kb7r2ZL
 5anTrbs26Eo0V1sVMsTdFZy647cG1zcOw78uubOuzUytFbaz8FLT9bmXZnj/sGzLxiWRnRMd
 fhspGk06d/E9i+8Cexm3eJe1q1/eEpGr2c91NIbxzq13DTwO4cq7mjNYVmxx/TRV/PUXjmoF
 3/f2ywO//eczuVPiaZn9q56XpU+DOyA7LLq72D7wP+dHzZ4/Eof/9dgpsRRnJBpqMRcVJwIA
 3VUjVekCAAA=
X-CMS-MailID: 20250211113504epcas5p1bf475ef119b45766066b492d2a7684c1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_46c76_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611
References: <20250203114445.64088-1-s5.kumari@samsung.com>
 <CGME20250203114459epcas5p33839b8e8150427947f9b5419ce9cd611@epcas5p3.samsung.com>
 <20250203114445.64088-2-s5.kumari@samsung.com>
 <Z6JOfy74ujK6r_UB@smc-140338-bm01>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=s5.kumari@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 11 Feb 2025 08:55:20 -0500
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

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_46c76_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/25 05:29PM, Fan Ni wrote:
>On Mon, Feb 03, 2025 at 05:14:45PM +0530, Sweta Kumari wrote:
>> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
>> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
>> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
>Hi Sweta,
>Since this series only have one patch, you do not need a cover letter.
>Move the commit comment in the first patch to this one and remove the
>first one.
>
>Fan
Hi Fan Ni,

Thank you for your feedback. I'll fix this in V2 patch.
>> ---
>>  hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
>>  hw/mem/cxl_type3.c          | 20 ++++++++
>>  include/hw/cxl/cxl_device.h | 24 ++++++++++
>>  3 files changed, 135 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 9c7ea5bc35..7a054c059d 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -86,6 +86,9 @@ enum {
>>          #define GET_PARTITION_INFO     0x0
>>          #define GET_LSA       0x2
>>          #define SET_LSA       0x3
>> +    HEALTH_INFO_ALERTS = 0x42,
>> +        #define GET_ALERT_CONFIGURATION 0x1
>> +        #define SET_ALERT_CONFIGURATION 0x2
>>      SANITIZE    = 0x44,
>>          #define OVERWRITE     0x0
>>          #define SECURE_ERASE  0x1
>> @@ -1625,6 +1628,90 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.1 Section 8.2.9.9.3.2 Get Alert Configuration (Opcode 4201h) */
>As mentioned by Jonathan, use r3.2.
Ok, I'll address this in V2 patch.
>> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in,
>> +                                   size_t len_in,
>> +                                   uint8_t *payload_out,
>> +                                   size_t *len_out,
>> +                                   CXLCCI *cci)
>The code indent here is not right.
>+static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
>+                                       uint8_t *payload_in,
>+                                       size_t len_in,
>+                                       uint8_t *payload_out,
>+                                       size_t *len_out,
>+                                       CXLCCI *cci)
>
Ok, will fix the alignment as suggested.
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *out = (void *)payload_out;
>> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
>> +    *len_out = sizeof(ct3d->alert_config);
>> +    return CXL_MBOX_SUCCESS;
>> +
>> +}
>> +
>> +/* CXL r3.1 Section 8.2.9.9.3.3 Set Alert Configuration (Opcode 4202h) */
>> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
>> +                                   uint8_t *payload_in,
>> +                                   size_t len_in,
>> +                                   uint8_t *payload_out,
>> +                                   size_t *len_out,
>> +                                   CXLCCI *cci)
>indent issue.
>
>Fan
Ok, I'll fix this in V2 patch.
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
>> +    struct {
>> +        CXLValidEnableAlerts valid_alert_actions;
>> +        CXLValidEnableAlerts enable_alert_actions;
>> +        uint8_t lupwt;
>> +        uint8_t reserve;
>> +        uint16_t dotpwt;
>> +        uint16_t dutpwt;
>> +        uint16_t cvmepwt;
>> +        uint16_t cpmepwt;
>> +    } QEMU_PACKED *in = (void *)payload_in;
>> +
>> +    if (in->valid_alert_actions.lupwt) {
>> +        if ((in->lupwt > 100) || (in->lupwt >= alert_config->lucat)) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +
>> +        if (in->enable_alert_actions.lupwt) {
>> +            alert_config->lupwt = in->lupwt;
>> +        }
>> +        alert_config->enable_alerts.lupwt = in->enable_alert_actions.lupwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.dotpwt) {
>> +        if (in->dotpwt >= alert_config->dotcat) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        if (in->enable_alert_actions.dotpwt) {
>> +            alert_config->dotpwt = in->dotpwt;
>> +        }
>> +        alert_config->enable_alerts.dotpwt = in->enable_alert_actions.dotpwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.dutpwt) {
>> +        if (in->dutpwt < alert_config->dutcat) {
>> +            return CXL_MBOX_INVALID_INPUT;
>> +        }
>> +        if (in->enable_alert_actions.dutpwt) {
>> +            alert_config->dutpwt = in->dutpwt;
>> +        }
>> +        alert_config->enable_alerts.dutpwt = in->enable_alert_actions.dutpwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.cvmepwt) {
>> +        if (in->enable_alert_actions.cvmepwt) {
>> +            alert_config->cvmepwt = in->cvmepwt;
>> +        }
>> +        alert_config->enable_alerts.cvmepwt = in->valid_alert_actions.cvmepwt;
>> +    }
>> +
>> +    if (in->valid_alert_actions.cpmepwt) {
>> +        if (in->enable_alert_actions.cpmepwt) {
>> +            alert_config->cpmepwt = in->cpmepwt;
>> +        }
>> +        alert_config->enable_alerts.cpmepwt = in->valid_alert_actions.cpmepwt;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* Perform the actual device zeroing */
>>  static void __do_sanitization(CXLType3Dev *ct3d)
>>  {
>> @@ -2859,6 +2946,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",
>> +        cmd_get_alert_config, 0, 0 },
>> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
>> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>>           CXL_MBOX_SECURITY_STATE_CHANGE |
>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>> index 5f365afb4d..ce5a4962da 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -956,6 +956,25 @@ static DOEProtocol doe_comp_prot[] = {
>>      { }
>>  };
>>
>> +/*
>> + * Initialize CXL device alerts with default threshold values.
>> + */
>> +static void init_alert_config(CXLType3Dev *ct3d)
>> +{
>> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
>> +
>> +    memset(&alert_config->valid_alerts, 0, sizeof(CXLValidEnableAlerts));
>> +    memset(&alert_config->enable_alerts, 0, sizeof(CXLValidEnableAlerts));
>> +    alert_config->lucat = 75;
>> +    alert_config->lupwt = 0;
>> +    alert_config->dotcat = 35;
>> +    alert_config->dutcat = 10;
>> +    alert_config->dotpwt = 25;
>> +    alert_config->dutpwt = 20;
>> +    alert_config->cvmepwt = 0;
>> +    alert_config->cpmepwt = 0;
>> +}
>> +
>>  void ct3_realize(PCIDevice *pci_dev, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -1030,6 +1049,7 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>>          goto err_free_special_ops;
>>      }
>>
>> +    init_alert_config(ct3d);
>>      pcie_cap_deverr_init(pci_dev);
>>      /* Leave a bit of room for expansion */
>>      rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
>> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> index a64739be25..6acae7d74d 100644
>> --- a/include/hw/cxl/cxl_device.h
>> +++ b/include/hw/cxl/cxl_device.h
>> @@ -581,6 +581,28 @@ typedef struct CXLSetFeatureInfo {
>>      size_t data_size;
>>  } CXLSetFeatureInfo;
>>
>> +typedef struct CXLValidEnableAlerts {
>> +    uint8_t lupwt:1;
>> +    uint8_t dotpwt:1;
>> +    uint8_t dutpwt:1;
>> +    uint8_t cvmepwt:1;
>> +    uint8_t cpmepwt:1;
>> +    uint8_t reserved:3;
>> +} CXLValidEnableAlerts;
>> +
>> +typedef struct CXLAlertConfig {
>> +    CXLValidEnableAlerts valid_alerts;
>> +    CXLValidEnableAlerts enable_alerts;
>> +    uint8_t lucat;
>> +    uint8_t lupwt;
>> +    uint16_t dotcat;
>> +    uint16_t dutcat;
>> +    uint16_t dotpwt;
>> +    uint16_t dutpwt;
>> +    uint16_t cvmepwt;
>> +    uint16_t cpmepwt;
>> +} QEMU_PACKED CXLAlertConfig;
>> +
>>  struct CXLType3Dev {
>>      /* Private */
>>      PCIDevice parent_obj;
>> @@ -605,6 +627,8 @@ struct CXLType3Dev {
>>      CXLCCI vdm_fm_owned_ld_mctp_cci;
>>      CXLCCI ld0_cci;
>>
>> +    CXLAlertConfig alert_config;
>> +
>>      /* PCIe link characteristics */
>>      PCIExpLinkSpeed speed;
>>      PCIExpLinkWidth width;
>> --
>> 2.34.1
>>
>
>-- 
>Fan Ni (From gmail)

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_46c76_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_46c76_--


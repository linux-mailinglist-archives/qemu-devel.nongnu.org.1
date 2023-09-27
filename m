Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E587B05DC
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlV0m-0002ji-VR; Wed, 27 Sep 2023 09:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlV0d-0002jV-Fy
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:55:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlV0a-0005t2-Rl
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:55:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RwdPg0zlHz6H7sy;
 Wed, 27 Sep 2023 21:53:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 14:55:15 +0100
Date: Wed, 27 Sep 2023 14:55:14 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>
CC: Fan Ni <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Gregory Price
 <gregory.price@memverge.com>, Klaus Jensen <its@irrelevant.dk>, "Corey
 Minyard" <cminyard@mvista.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 12/19] hw/cxl: Implement Physical Ports status retrieval
Message-ID: <20230927145333.00003e0d@huawei.com>
In-Reply-To: <20230925161124.18940-13-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
 <20230925161124.18940-13-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

...

> +/* CXL r3.0 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
> +static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    /* CXL r3.0 Table 7-18: Get Physical Port State Request Payload */
> +    struct cxl_fmapi_get_phys_port_state_req_pl {
> +        uint8_t num_ports;
> +        uint8_t ports[];
> +    } QEMU_PACKED *in;
> +
> +    /*
> +     * CXL r3.0 Table 7-20: Get Physical Port State Port Information Block
> +     * Format
> +     */
> +    struct cxl_fmapi_port_state_info_block {
> +        uint8_t port_id;
> +        uint8_t config_state;
> +        uint8_t connected_device_cxl_version;
> +        uint8_t rsv1;
> +        uint8_t connected_device_type;
> +        uint8_t port_cxl_version_bitmask;
> +        uint8_t max_link_width;
> +        uint8_t negotiated_link_width;
> +        uint8_t supported_link_speeds_vector;
> +        uint8_t max_link_speed;
> +        uint8_t current_link_speed;
> +        uint8_t ltssm_state;
> +        uint8_t first_lane_num;
> +        uint16_t link_state;
> +        uint8_t supported_ld_count;
> +    } QEMU_PACKED;
> +
> +    /* CXL r3.0 Table 7-19: Get Physical Port State Response Payload */
> +    struct cxl_fmapi_get_phys_port_state_resp_pl {
> +        uint8_t num_ports;
> +        uint8_t rsv1[3];
> +        struct cxl_fmapi_port_state_info_block ports[];
> +    } QEMU_PACKED *out;
...

> +
> +    pl_size = sizeof(out) + sizeof(*out->ports) * in->num_ports;

In cleaning up up my tests I added a missing check on the pl size.

First term should be sizeof(*out)

> +
> +    *len_out = pl_size;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAB7F50E5
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:48:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5tBc-0002Z1-SO; Wed, 22 Nov 2023 14:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r5tBY-0002Yn-HZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 14:46:56 -0500
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::609]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r5tBW-0002vd-6U
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 14:46:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMVtYIWJ2yQRxk070BDWhUjzYtppkVw1HXL9Ak2frTc9g3eQzNnodWC1s+i4eYUIE/u0VIgaJIistPDM8uymK1WTrLlCjAq1ikJwkHF9Wv4PCGN+XhCrtYZ4WTZEt14KMuDrDqwr3SGot4+EhdasB2CWdxB5cJ4PMFKLr/PKuZk0+4g3f8C2M+w0MQ2ogh3jdCox7gnpWMl/eyziBG+Mt2bY6B4AdulWicMCBZp1EDN5pWe0VzWuPDjZKIUtXIBQXQY/YWcASvQ7P5wUZGjWmM+qtq10tmhZVTBvi+JG7IyBP4SPddPEo50/iBE6OCf7YdEzzLXUFqq0G+Ej2KQR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So0OOI0bQMgbj0JWZIKpfjVb+7fhFJkWZKOwUoAhmto=;
 b=f7RarN4boexJiJi4N3y+mxFz1i9Z4G5AwLGvEPZDvTG+jv00AxGuknOxYXfmKw7OFZvdqiibuBib0JGKO3g5aT3neCEZbnYcRkYrHsz4y1tYs5nr4maM58IGAzw+zkIQPMCkYfXuBOuG5WcHQbAwnXB2lwYRGJU8U44D6RRdyj8roATL+OxBpLtopheH003GwBs2Z/qUz7dT8rjagTC8nOs6IHe+5HRW41Y4poX7aMpa5KwRtd/n/bPWnGRGN/3VIyzPgwM49SjJlNP/6+vkqZpW5GesnZA0xqGnw6chSNZzwVSXlU1c3nIPMxiGO9IfKzWa7FAMFCnO/k2fvPR8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So0OOI0bQMgbj0JWZIKpfjVb+7fhFJkWZKOwUoAhmto=;
 b=jg91yjjjPbh6fkerrnOMmHoyW27yjP2PrWWKXtZxMRzFDgApU3G8J6o84YcKTzkcDe8v532CDnDPAzbFTGGJ3m8UQqK7+/V/ky+wWKE864L2B7/+xujkJD7fquYFykBQh1ZJhOOM3NYQaDW9L7BoRsimr0ro4iHi/Gp7BXcWdbo=
Received: from CY8P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::6) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 19:46:50 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:6b:cafe::ad) by CY8P222CA0013.outlook.office365.com
 (2603:10b6:930:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 19:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 19:46:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 13:46:48 -0600
Received: from figlesia-VirtualBox (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 13:46:46 -0600
Date: Wed, 22 Nov 2023 20:46:44 +0100
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Anton Kochkov <anton.kochkov@proton.me>, "Vikram
 Garhwal" <vikram.garhwal@amd.com>, Jason Wang <jasowang@redhat.com>, "Pavel
 Pisa" <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 "Qiang Liu" <cyruscyliu@gmail.com>
Subject: Re: [PATCH-for-8.2 v2 1/2] hw/net/can/xlnx-zynqmp: Avoid underflow
 while popping TX FIFOs
Message-ID: <ZV5apPNzhdv161FS@figlesia-VirtualBox>
References: <20231119225102.49227-1-philmd@linaro.org>
 <20231119225102.49227-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231119225102.49227-2-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: dafa1403-342a-4756-edf2-08dbeb93c540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbKDvCgxcjDwyHdxiU98M72O1SbhCMMk+hXtzJCqPuZEOrmLSOcKD6VJl7nPky0uahN9Wpf/b4TQAj87LJDrYtMavdXwd6zGuwrOiVfTnoD4C7fbLT0cMB1CVOCptJ2vALiB7TPiVb0Rksc7ZmywY4enDM/L+bO7rR6xVdalK1BYjDeIO1DeJuiwPwmAogrga18rzAB27qhS0WkGLcmtfrfZ4gAjYil/GSmDoLX484ibnT+CYVvDw0TZHUiVzGXh1zm/H3wzD2kOjD5Z7J9SxF8Loog5tSkfKmWQbAJD1DaT8h8xNk7TqcdZlqBie4ewp4SuDDt6w80nDzAiarPiY3z4RK4uhGXLvy2k6hIRwMwcpZFZeclQD1yzpJXuMHNg3q6YkKpcMHOJpg2VvYZdbefYGJB6+gpEX8Tm4/8gRNDB41evRKqOcntJK1wN6oypSqmXgD1gWMNlOiB1Am78r/jYrwrtWvKB3Nhiw1TZGX3RYvloTj8q68hAjh4rJzgO/Udxlc8hKRPyRuN3r/XdBs3XFtQ9ueA06nO6r5ZSujhKBveActiYmfURteUseSQ0h5fgAo9LtbEcIvS8r9ZCgxVJYWpUXLDeheWF2TiOx0eTu+LreYjX44mC7CQ+abTiFw3leaf6dNgM3UtAe9IJKccd7tnqPe7sMCyYd8ERRGCSqQI19rlCexO/monESkSOqYQSOQ6O6ivDf+8S4YWva7svB4k9ApWtx1OvGlTRHOOzGaat8KNZ9yM/0wAlQzyaO0sfuvotrXosOz/SGjQi4HCCeY24fxX5RD45SKXE3D4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(426003)(336012)(26005)(36860700001)(81166007)(86362001)(356005)(82740400003)(83380400001)(40460700003)(47076005)(316002)(6916009)(54906003)(8676002)(8936002)(4326008)(70586007)(70206006)(55016003)(41300700001)(44832011)(5660300002)(2906002)(33716001)(9686003)(40480700001)(966005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:46:50.4050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafa1403-342a-4756-edf2-08dbeb93c540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
Received-SPF: softfail client-ip=2a01:111:f400:7e88::609;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Sun, Nov 19, 2023 at 11:51:01PM +0100, Philippe Mathieu-Daudé wrote:
> Per https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Message-Format
> 
>   Message Format
> 
>   The same message format is used for RXFIFO, TXFIFO, and TXHPB.
>   Each message includes four words (16 bytes). Software must read
>   and write all four words regardless of the actual number of data
>   bytes and valid fields in the message.
> 
> There is no mention in this reference manual about what the
> hardware does when not all four words are written. To fix the
> reported underflow behavior when DATA2 register is written,
> I choose to fill the data with the previous content of the
> ID / DLC / DATA1 registers, which is how I expect hardware
> would do.
> 
> Note there is no hardware flag raised under such condition.
> 
> Reported-by: Qiang Liu <cyruscyliu@gmail.com>
> Fixes: 98e5d7a2b7 ("hw/net/can: Introduce Xilinx ZynqMP CAN controller")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1425
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Francisco Iglesias <francisco.iglesias@amd.com>

-above line
+below line

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-zynqmp-can.c | 49 +++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
> index e93e6c5e19..58938b574e 100644
> --- a/hw/net/can/xlnx-zynqmp-can.c
> +++ b/hw/net/can/xlnx-zynqmp-can.c
> @@ -434,6 +434,51 @@ static bool tx_ready_check(XlnxZynqMPCANState *s)
>      return true;
>  }
>  
> +static void read_tx_frame(XlnxZynqMPCANState *s, Fifo32 *fifo, uint32_t *data)
> +{
> +    unsigned used = fifo32_num_used(fifo);
> +    bool is_txhpb = fifo == &s->txhpb_fifo;
> +
> +    assert(used > 0);
> +    used %= CAN_FRAME_SIZE;
> +
> +    /*
> +     * Frame Message Format
> +     *
> +     * Each frame includes four words (16 bytes). Software must read and write
> +     * all four words regardless of the actual number of data bytes and valid
> +     * fields in the message.
> +     * If software misbehave (not writting all four words), we use the previous
> +     * registers content to initialize each missing word.
> +     */
> +    if (used > 0) {
> +        /* ID, DLC, DATA1 missing */
> +        data[0] = s->regs[is_txhpb ? R_TXHPB_ID : R_TXFIFO_ID];
> +    } else {
> +        data[0] = fifo32_pop(fifo);
> +    }
> +    if (used == 1 || used == 2) {
> +        /* DLC, DATA1 missing */
> +        data[1] = s->regs[is_txhpb ? R_TXHPB_DLC : R_TXFIFO_DLC];
> +    } else {
> +        data[1] = fifo32_pop(fifo);
> +    }
> +    if (used == 1) {
> +        /* DATA1 missing */
> +        data[2] = s->regs[is_txhpb ? R_TXHPB_DATA1 : R_TXFIFO_DATA1];
> +    } else {
> +        data[2] = fifo32_pop(fifo);
> +    }
> +    /* DATA2 triggered the transfer thus is always available */
> +    data[3] = fifo32_pop(fifo);
> +
> +    if (used) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Incomplete CAN frame (only %u/%u slots used)\n",
> +                      TYPE_XLNX_ZYNQMP_CAN, used, CAN_FRAME_SIZE);
> +    }
> +}
> +
>  static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>  {
>      qemu_can_frame frame;
> @@ -451,9 +496,7 @@ static void transfer_fifo(XlnxZynqMPCANState *s, Fifo32 *fifo)
>      }
>  
>      while (!fifo32_is_empty(fifo)) {
> -        for (i = 0; i < CAN_FRAME_SIZE; i++) {
> -            data[i] = fifo32_pop(fifo);
> -        }
> +        read_tx_frame(s, fifo, data);
>  
>          if (ARRAY_FIELD_EX32(s->regs, STATUS_REGISTER, LBACK)) {
>              /*
> -- 
> 2.41.0
> 


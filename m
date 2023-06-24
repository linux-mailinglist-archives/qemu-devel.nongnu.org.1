Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C7173CAA2
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1eL-0007rR-Nx; Sat, 24 Jun 2023 07:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1eB-0007qv-NG
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:41:44 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1e8-0005ru-U9
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687606898; x=1688211698; i=deller@gmx.de;
 bh=/Oy1U4r3hHC454wVxS64IAqK7/9uXk8ajYzsP3ZR7Wc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=OfhLB4Yu94bbx3V2mBCGzVwWUigHDvFT7a2WpdB54tUO3cV80EXyU/J3bD70YdCMTUm22EM
 +ZT7qwVLw+fIeZp823cP3EexfY/9CjJE79aC4KI7GKBgwcmR7iP3yRcmqPUwPLKbNBYlHRb+P
 IfJHfrLsY7OE1DkjsWuQhru08UkKRRhxQlQX/gM6RfbKfp27tAWmtTDt7x5RtZX1JvV0FqLx7
 3DHp+qpkajkn9WL0eMOXi30LLTaZQe2Fc1xMtFrawxJ9c6VkGzZP/TniHsGnYqetoyrSPM+Oc
 1LfFEj9YC8Ub1j8dqQxzPr2AE52n2NchtdSsDFaxCn4QNPFJ4UbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.152]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1qCkWv1CK3-000tA4; Sat, 24
 Jun 2023 13:41:38 +0200
Message-ID: <7a54732c-f045-02e7-960b-2271e88a130c@gmx.de>
Date: Sat, 24 Jun 2023 13:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/3] Hppa reboot fix patches
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230624112915.27033-1-deller@gmx.de>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230624112915.27033-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZeQxx2uLeiCGKC2zEBnG8Y9IOTcqV4pRc1QrjA7/FJtjaLf8kZD
 nvbs3+mwhgBlQBDZGZ8sKWwow6IirF0b7hNrZM0WmX+/2R17Vb5sQEqfSqa48MjLA+GVxW9
 0YT6t6rPigmX9dgxQy1rlzCRUPwEDYzbv4wpVr9djrA3Kil7FGBwVEWfvgINtj7EKS3uiUC
 v5kFkpVSXHpe7H+Xr2HGw==
UI-OutboundReport: notjunk:1;M01:P0:5fL5t3zjV+k=;IRsfHcvFhBufuVMa7T2ljHCUN1z
 ctlAkUodqXnfkzXCsl2LaqIYGyI+N2It6yF+ne9IYSHu6xnZ5UWqrlKU3/CM/RccQnJZCi3D6
 +TIHdlq+f8BiiUdLjEWg3jYW4FoCQHDl8jzxgKz4nFXHsriL2iJhPnssnjPX08nADuCzvKx0A
 dRVLkUVfDzSCB/RPgOlGMxSGYJU94wINia+BvLreq0FSERh5NTaP2HqH+1lIZyOo4ofLkiI63
 6iLub7l9VQd1zUTbtMKW0NNPM957xu7GncmFRw7jpxsmPKTCe8ys3gLKD2BJ3H4BiletT9nYX
 WKyjkNL7/madpkPhjvwE1FebmD3PunZULyEw9jomKIHIlGJRecg5Xg3/1N4KpLHoaq5Owi4h7
 ocT5sqJvv0QPTcl1VU7n9ie9CuYrwJk4j0QxGd/7REaNmYT6O4y88h+m1TYdxMbSQ3j6KB5vS
 RkoYbyYg2jQIoaJq3qdtbSkQv315icRcPdJm/EHcCeRt+GxcW84wM1cfad2ky8qeNBDh/lZEf
 0tpUcwESYef8iQ0Rg7LPvZblgbAvWWrLJHOQtT36Xx/bD3OgbFM0XI53Gx/o/dM6JF5yzierN
 scbDrrYeiCwvSglRLHKO92fK/y7JJ8tp6gKUOCKLwdl7DHAOmtT2od5lpTFZ4NTxmmJo0shVO
 CwKahY1+tOzaWB53UJUUy9qOu4fEA9NQqqsf5MBeBU/FVo3Wa2GPTZCqNNtJ2F3uSQ3H/RfRv
 tMdCAy+ARr9VF5JzWGVf3LtEYaZauRZfUyNFPX4b+SZyebNZ78jaA3/5w6R6JKKq5/thVukiO
 2+5gixIB0WlSCB5tVHqy0Hp0FvMya3jqfKXw//JqyCiu2rPwAqjFxGkDahGVcVp5Gky5E4CXR
 V7XM7RlfCarRBWzXTseAwPZZ9o0Loa369xifR1gUtlqiF/T4Pm2KykK6IW8+M6l/JhH03cuIV
 56ruvpckwLTYDlMIo6hMC7EzsbA=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/24/23 13:29, Helge Deller wrote:
> The following changes since commit c5ffd16ba4c8fd3601742cc9d2b3cff03995d=
d5d:
>
>    Revert "cputlb: Restrict SavedIOTLB to system emulation" (2023-06-21 =
07:19:46 +0200)
>
> are available in the Git repository at:
>
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-reboot-fix-pull-re=
quest
>
> for you to fetch changes up to b9bed0896e8352a340188e32bee69988209e4f72:
>
>    target/hppa: Update to SeaBIOS-hppa version 8 (2023-06-24 11:45:52 +0=
200)
>
> ----------------------------------------------------------------
> target/hppa: Fix boot and reboot for SMP machines

Please ignore this pull request, as it is based on a wrong base commit.

I'll resend a new pull request.

Thanks,
Helge


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A441BE66C4
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 07:31:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d1z-0001tL-UT; Fri, 17 Oct 2025 01:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1s-0001qt-Cq
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:29:28 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d1n-0001qI-0O
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:29:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.133])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cntfj3YClz5yCB;
 Fri, 17 Oct 2025 05:29:17 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:29:16 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0018d368074-810e-4f4e-9795-4749d57254d7,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9afefc7c-d2f6-4faf-964b-bc628739a4e3@kaod.org>
Date: Fri, 17 Oct 2025 07:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 10/12] tests/functional/aarch64/ast2700fc: Add
 eth2 network interface check in PCIe test
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
 <20251015062210.3128710-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251015062210.3128710-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0b648da6-643d-4313-9f28-d3dd84d3cdc1
X-Ovh-Tracer-Id: 15288876312522558255
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEx974HFSf25uOSe9WnO5Z99NUeUj/jTkEPO9V2akqTidJHah/i270irkKGHyAgQorjjAApbUR/QtySvVWNRbNIj2TQNcK25nzhAkG0wQXy7L5Nb5b5G/vmjOPCQZ7L/y/zQ/iOy0scWF2uSGqkw/QkQhG+Jd03crzykmam5tMCK59KJhJIPN6VdHF6bv7eriwH05B7+6wjHaXAA+uVJ8qF4Vbc3MCJ63xvJ7qHtJNX4xymMUJqT0IoU6KIy0xe8g/MTIlHVcX9bd6C3XfZH7/mM0SfcVCv0EOb8hmJNl4ItZAZcjj5Buft3VtKQm9BDW7qm7nYV6zTfTyjTHcykYnimWh1GsEgmh9ZlB6egcnkS20GhHtxVi10Bcd94NxCcuxpID9kashFCU/spZbYT0fH8pyCg/7H3LVsYPI3xIUN2n2hsB5f0zpiPf45MUFcLJN5jG+SNEVQWgNx7VbXMnsZCbrw1aXCnqKBFwhhvgtgXiTrELl9QLXot7NH0lL1rsvTVmi6ayWHQU1f0ojjVsT0KyR+taUluYvJNZsx2XNB8c/o2FU0ULDpvFCnCeTSnCld34nm0HBW/4Qp86SJeX56uwA9vrqmTr2hu/zIzCtRPMFz/Ne6yvgMQki+Rwy0BSq91h30t7eg57UGYDi9LIL7qtgw2gckLRsYqrHkJUi8Aw
DKIM-Signature: a=rsa-sha256; bh=DGgJIrT+4i4aJbqYCmnXmv5G9DTcZ5YJiokmdH/Bj+U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760678957; v=1;
 b=mwCDuU9v/2afyPY1aEFkirv5DJCXgrlUl7S1wiVVl/MMq3xHfNiOB31CgZVOnaLMiWN74lha
 XiaTOP8wUfh1YK5HbWCOg/P4lMSAkwMwGbfpu7thtgKWMbwwZDHxEpsqThMg8BcHmXplU+fIKM8
 W8K2gkuSzoOHandazCdVuqmu4B3++lmRC+t0tu5WdBcvtCdV7AlmFR4J8pUxdbnBKEV3qr6kaeF
 2r0jKontb9dRbUjQCMzCHOyzp7WgCI85ZgF6/wZM9sVSy0CtdIEHMT9lbT3M8nH4b5p6lpPx81q
 GAUKgU5DOXF7w1FMMUMMu40DooWsB71GZRGsaLjZNU+Jg==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=clg@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/15/25 08:22, Jamin Lin wrote:
> Enhance the AST2700 functional PCIe test to verify the network interface
> configuration for eth2. This adds an additional command to check the IP
> address assignment on eth2 to ensure network functionality is correctly
> initialized in the test environment.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/test_aspeed_ast2700fc.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> index bcce0c8d4e..843647e6c5 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
> @@ -60,6 +60,9 @@ def do_ast2700_pcie_test(self):
>               'lspci -s 0002:01:00.0',
>               '0002:01:00.0 Ethernet controller: '
>               'Intel Corporation 82574L Gigabit Network Connection')
> +        exec_command_and_wait_for_pattern(self,
> +            'ip addr show dev eth2',
> +            'inet 10.0.2.15/24')
>   
>       def do_ast2700fc_ssp_test(self):
>           self.vm.shutdown()
> @@ -135,6 +138,7 @@ def start_ast2700fc_test(self, name):
>   
>       def test_aarch64_ast2700fc_sdk_v09_08(self):
>           self.set_machine('ast2700fc')
> +        self.require_netdev('user')
>   
>           self.archive_extract(self.ASSET_SDK_V908_AST2700)
>           self.start_ast2700fc_test('ast2700-default')


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




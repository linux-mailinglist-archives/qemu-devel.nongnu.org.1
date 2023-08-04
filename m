Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D076FE65
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrzK-0006k1-4q; Fri, 04 Aug 2023 06:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrzI-0006jn-8o
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:24:52 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrzG-0000NF-P6
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144688; x=1691749488; i=deller@gmx.de;
 bh=BNwtzmIPlMLQ7XFvV2xy5vIPAuoLi7uhLvIkLieOCtg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c/ItRbyY+sG8vTghKExtVPJnVh6m8BPVRBYDqIV9oyMid4yBTfEULDHe/IfFXQtutIwSNF0
 Be8KHRO6mT0xdlyQewK+5WX1NH+wRrLs3AmYeL2bjol1FW52340+zFwpXdq5//fL6t7QYhH4b
 cNhs8M7rHggxhDClGYg7oEwjLf52M5y3QpNC5L4pflW7gRToha+98bE/oYhllq26b91E8YwNF
 6vrjt2l+6jAbzo1gfdzjLMMja3MK7k60QKJNYHyqn/X5dxN9dobQhR90FIG1ovT2w8TWq6iWz
 cHCihTWF7EWEGklRo92fAUkOlqclbLs335xTnyJss41p7l0AU90A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1pyuHn0viZ-00mNlm; Fri, 04
 Aug 2023 12:24:48 +0200
Date: Fri, 4 Aug 2023 12:24:46 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 16/17] linux-user: Do not adjust zero_bss for host
 page size
Message-ID: <ZMzR7n0TQmwpAjWc@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-17-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-17-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:rQhPCe5J9yAAm2p8p18Yt1TUYGFSKcjQodSM6WFMIbtRlGYs/Vf
 dGVdC9BrlarZG3YIpKz3/g7uXeiHl7w8eRuU1xfotsycPj9xayhyxe8qBbpinmkiAlj34gf
 tj9+X57lmZxVv9LoDGtvhnp6tvQx9B+8XY6jiH7m6J0uIofdDlGrjFXyAnLoDbz3RiUdXbA
 VNtpB0tYeY8k7NSR07B7g==
UI-OutboundReport: notjunk:1;M01:P0:x6F6+jxMrww=;yFjVIjq/Ndd7n1NmYlD07kmJXoU
 4ol0DQ8cgXjtT7LnrDbtBUf6DLk8UZ2D+QPPaxBIwPACIIS4gs9IO737S1FsGzqGATtE9iIrH
 Fv/B3sOUFzk4PUcnAjA76lXZBErda64ny30KNg2r+vaVlMXUeOnmRQPL2wivGm1D3XJ3jc7To
 wU9utcPzNT3YrKU2H5nW5SLTqtTPHdoTH+yATHNIl1hO33WAIXg7sXfVSc4BfBv0KqE5G/1Mo
 l5KkLhehG5GXX0fDeuNHRlBsvA7VekhIT/7ivdDgAaf3Ty8S7LQPegwsz8mswJy62o98Xt69X
 V6yl74SyWq0ZjCXVCiVmgQmDtIqrm07rwNIFK9O+HaqJMs/mxaGbUOc0S3C4dQIDamf8LVmx7
 OYWJmXETrjzJN1E3d+Hx6uO6HfZil4GpO7s3gZrlaBLbIYiQ0bvXefz88R7Zzu4kZ6sqSOKPf
 /Pa29b9pBcOoHIcPVWIw/vnzuVsGPFNmKGh8Fb+TkxE7NWXVapb6Wsb5nybeFcuwiR0PB1ldt
 v2gzTqLXl9QvdHpU812Velw+k7NrERk9g30qpDj8I9EXUaZ78OZwSd50i0Eb32zEDxuK8QZ9G
 HA7O0gE35qH/U3XRz51/k+aw8ivL9TR4dibm/2AdZi83h3yL+M61gPJmHwvNn5WMbHNsennl6
 XadO+faJrguTo8M7uG+FrrjJXQFMLxm8VPZ8Yqt8wKWFVNNg5I7xIL4Ij7fHFWtTH7OlvYDLJ
 hh/8hlxvDzRRSukEVFNSHTetEp4qw2sFm2ItTrmLYO9HlGXlJixbqoIIwsFGKXZmxcyhZiuTr
 JiQXHdQyfqNlL9PW3RRtA+qicx0jbuqAwV6sUXQWORUG3F3Va8yb6GRx36NOKhm2af1FKR2mP
 qfR+fy85Bockw29XuS4NdmHoHJRvJWe8RrlvSFtVelT+XyN9EQgEYqu01QHIN7+Hfm0x2NAT0
 m6H7GwQI6B1SB1LBVD6QtUjbCbA=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Richard Henderson <richard.henderson@linaro.org>:
> Rely on target_mmap to handle guest vs host page size mismatch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


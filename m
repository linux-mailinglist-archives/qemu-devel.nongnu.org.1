Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BD7D474A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvAlD-0001Yw-Ny; Tue, 24 Oct 2023 02:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qvAlA-0001Xr-63
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:19:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qvAl8-0001ch-8W
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:19:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C81C2CB1B;
 Tue, 24 Oct 2023 09:19:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E532B30C3C;
 Tue, 24 Oct 2023 09:19:10 +0300 (MSK)
Message-ID: <3c1f63c3-f1bf-433b-a867-40bcb0dc21f9@tls.msk.ru>
Date: Tue, 24 Oct 2023 09:19:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 21/62] hw/display: fix memleak from virtio_add_resource
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <cover.1697966402.git.mst@redhat.com>
 <9b50fd02900c11e6e50c7913e5772031749b3e8d.1697966402.git.mst@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <9b50fd02900c11e6e50c7913e5772031749b3e8d.1697966402.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

22.10.2023 12:23, Michael S. Tsirkin:
...
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Message-Id: <c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic_mathbern@quicinc.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>
> Signed-off-by: Matheus Tavares Bernardino &lt;<a href="mailto:quic_mathbern@quicinc.com" target="_blank">quic_mathbern@quicinc.com</a>&gt;<br>
                                             ^^^^^^^^^^^^^^^
FWIW (the patch's already in), - this is not the first time a pullreq
contains such hyperlinking.

/mjt


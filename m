Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E756776FE5A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRrxI-0005Jn-2g; Fri, 04 Aug 2023 06:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrxG-0005Je-1I
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:22:46 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRrxE-0008Nj-6u
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144561; x=1691749361; i=deller@gmx.de;
 bh=MVQlhu8DUrfZX2NFWVsKMccQsz0MN43u3rqieOjaPN0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cP3CTWLO12yicZxDgv8sxUMAvlmqKHjA86FutlAyayP7BHBce9hiVDxs+kWpb6QaO4Yz9mr
 Xz8VJJZji4cdiMuNhvCj4GUXYdHjYMcYSlPc5ctDUpfpceQtu+Vdud8ImZD0/Ou6CdfVwF/tP
 NyWi9+XKxXYidYcKoJD0bUy47ER3no8EnvgBbr7LiX4gu6Wo55Ayh/TFFLFq2iUNfK+0/wvu+
 K06wniLE/mF3zGbRN7xeBWxdTE6T3KE41mrY81fTqgh9JO7fKl5B9JAzoBO1l4XV24qHwLIVY
 aEzUDLhOT7t+Dand7l9I4bQu6qiqGDX3if5WtGyvqPE7OX6ynfHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1pwuun1bjU-00dkGk; Fri, 04
 Aug 2023 12:22:41 +0200
Date: Fri, 4 Aug 2023 12:22:39 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 14/17] linux-user: Properly set image_info.brk in
 flatload
Message-ID: <ZMzRbxZMYDef3kHa@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-15-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-15-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:bDQMbR8JkczV0yOOCJxoTXL/ZbL27YXMmAhSG/eq/nsIcpxssGk
 m2XhB8iSiS4kfEgnNuCgMsoBQ+ru2PlG45/PHNOytUWtu/nrma1UWx0ZkdLesEfg6le49+R
 nw3ISX9Q4G29wlx+7M3DeqOfW/3Jvs1/pjXVbDv1tXWARmJ8bFu0oAXJEj1VUvI1AkI2PAi
 pQ61KcPI1wkZumiaDJOqg==
UI-OutboundReport: notjunk:1;M01:P0:OsSF49jT1C0=;MAXy5PytVuIeKtXXPxKyBZR8CQ5
 bxC7pKFzq9gwMinVu3h8Vc+niovJHRgwevNyp7X8YvKB5/R8vWcd4MCowsFe/not+KZ/My4oX
 /S7p8K8h/bIF1vLQhjvUMtOfMeYqEbJri7hs93ehFLx6HL+mHCCKiSiOrDwNX8G+2puxfAij3
 yXNRjq9qNqhOo2l6C1y6x6kEY8/OTERUi6VuSP5qG479CVhlRQoFCKTv5Xy7v4pOx6sd4ccdh
 MFSTz8Oo0izriK+u1rl6BwcivMBf75kWN6b1W118wIicHeK3lqlXm3s81eJCx8On2UVZXMNqC
 xY/O8hUlGCzUhGim6MJQvnOkn0WW3awv/tWsN9rWvvL9sagWSCTn+Uepnd/rGMcERJFpE99bY
 XYitZ5287ARKtlkiM1XXggKU1sGBcyO/yMGkJi0HRH+qJRrH6ub4g1ShyXkJVjjOBFASiGaEA
 lu20ZGvUnbU2nRpEpxJEDOyw0CAQkIo4xRzpt/PlH2/wzFZZLtq2eASJ91pXPWAPPGTm7VoEU
 U+0z6bgUF9rbE6wNjjHy6l3sIkm52hV3o0oGa8xJINC19wjyjVO/sn0SwfEO00qEF9EkQfXsL
 I85qWq+NysKYZRxsQFWetOCkaAaIjxQ3A19nLEtx1qbP7SWqJo/Kk85wMLKfqF1jbOcL8AS+u
 sY5643IHH7Lj/OBdTf3wm6uaYITpTZWRwBUOX1RVVtda+L3tRs58APaK9iOwHBo1QjNsm5TZ0
 bLtrwqXXBRfqYo1REb8hFGqozHMUutM5y+YUuM3PONmM2IK997PPWPcP/E3myRV2IQO9RFdz1
 ztZAkS+3J9jVfuIyAxYakcm0MvxiqQf2mo9oVwA/cPg7hcEiQih/qRVpwEVkTiZL3P8KPsbFZ
 EBsF1bpvyK9RAfD3RtIdotXjWmOJ6aMAScsI9X7PUlBByjPE1tkoLyfNK9LtGiPqEOzHA5tAA
 5ASjiq2tlqegCP17FCuhGAgwwAs=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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
> The heap starts at "brk" not "start_brk".  With this fixed,
> image_info.start_brk is unused and may be removed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


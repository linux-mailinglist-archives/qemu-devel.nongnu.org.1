Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D557E2058
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:49:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy1h-0001Jo-3T; Mon, 06 Nov 2023 06:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qzy1e-0001IO-GC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:44:14 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qzy1c-0004pg-Ri
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vBjlULdVvtFrK0HLLPtwPIDxh3uhYdmMjr1TskNH934=; b=cVVAUVbqla2d9yVFZzJ0HY/1Zy
 zkxC9g5Xgh+uMA4mIKZ65aesawmvzH0vOQp9B17B7u0WtROCIubX/XLLZBb+uUdK7vtV6MvaA0l/N
 GmzVBDH33KZ4kdkewGXJ9uwO7xvXeqEnCoFjzura2gf9d0ar+HSG8hPm60wLc+sYONqUWH+DZslg7
 omSCH4xTyEJmDi4k1DlYXk3IXb/qsX8cxsTOqyU0XIfttMCTRwngknDnHUkIMQMoTLBBeQwgU8XZs
 iUzyo9NeOY1+aH6KhbEa4Tog4hIahHhIQDE3H/neVRZGviN0DWjJ0X92G3GKQBzjiaP73tY1ycFdK
 OvVAXxFV0gq/EDLZDyLjl77aQhiW7pEW0aLJVXV/qqIJZHcNEEhmpi2ACdLCl9cUbOpMy53DvUmXH
 rgqKiiIaYM9DdemR3n2yiffmulXRWeaC4nU8Le6cDYIuKds0yBz1Jz8KPPeTnwGB2afeCuQCXjl6M
 SSpPL1Pdh+o8yjiYyjIry8I85JMfjO4D2sKh+oMCTZfoNK9zZK0jhApBFxv7C5JUX1iNlSOnVdWbb
 cKBZhiPoIxmMxNJqGULBz9Wvg4Y3CQzydr6mSLcYWib7y4PQ56M1wjHu7+cltRGdUT0MzmZoBoKo7
 PUzF9kjZmTwAApSyHgpIqI+4vO8EMHgd7vPJR+A6o=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 20/71] hw/9pfs: Constify VMState
Date: Mon, 06 Nov 2023 12:44:07 +0100
Message-ID: <62937420.3DG5BLcfXi@silver>
In-Reply-To: <20231106065827.543129-21-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Monday, November 6, 2023 7:57:36 AM CET Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/virtio-9p-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 5f522e68e9..efa41cfd73 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -237,7 +237,7 @@ static const VMStateDescription vmstate_virtio_9p = {
>      .name = "virtio-9p",
>      .minimum_version_id = 1,
>      .version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
>      },
> 




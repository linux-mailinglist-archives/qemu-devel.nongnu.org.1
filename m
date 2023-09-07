Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212FE797F6C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 01:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeOqa-0001Z6-E4; Thu, 07 Sep 2023 19:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qeOqY-0001Yh-AH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 19:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qeOqV-00063T-KK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 19:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694130934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0yRFpSQVdiKN9ndc3rjxohihKqoTNq6bxCnYdahPPc=;
 b=HXXEFx5mmttKDjulORXiP0Io5Sqhk4qCbJp6OXYM+ti5+lkE3xagGUbdAERFumkZkE9piy
 DZaOhBh68XcCyA6V9Z0z9yuW7OCvvJrMRlZK4wkgbbkEobGizFRTm8CFlWdw61XdLLo3fA
 5nYGdK8wmJMITvvt1f1VFSvnCUFQMYM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-Bd5HaVfgNk2PW-b6AjHTnQ-1; Thu, 07 Sep 2023 19:55:31 -0400
X-MC-Unique: Bd5HaVfgNk2PW-b6AjHTnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0698E1C05122;
 Thu,  7 Sep 2023 23:55:31 +0000 (UTC)
Received: from [10.39.192.25] (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B21412026D76;
 Thu,  7 Sep 2023 23:55:27 +0000 (UTC)
Message-ID: <bfddf3fa-0b14-25b4-39d6-e3f65b659525@redhat.com>
Date: Fri, 8 Sep 2023 01:55:26 +0200
MIME-Version: 1.0
Subject: Re: riscv64 virt board crash upon startup
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu devel list <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Warkentin, Andrei" <andrei.warkentin@intel.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <139b9697-5732-dafa-0942-6d93eed674c7@redhat.com>
 <1398e971-8115-13e1-6ee4-4c46df0814dc@linaro.org>
 <fe0ebb81-30b7-9e60-e9b5-7737c562274b@redhat.com>
In-Reply-To: <fe0ebb81-30b7-9e60-e9b5-7737c562274b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/8/23 01:47, Laszlo Ersek wrote:

> I don't know why qemu_console_is_multihead() used a lot of QOM
> trickery for this in the first place, but here's what I'd propose as
> fix -- simply try to locate a QemuGraphicConsole in "consoles" that
> references the same "device" that *this* QemuGraphicConsole
> references, but by a different "head" number.

So, the final version of the function would look like:

static bool qemu_graphic_console_is_multihead(QemuGraphicConsole *c)
{
    QemuConsole *con;

    QTAILQ_FOREACH(con, &consoles, next) {
        if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
            continue;
        }
        QemuGraphicConsole *candidate = QEMU_GRAPHIC_CONSOLE(con);
        if (candidate->device != c->device) {
            continue;
        }

        if (candidate->head != c->head) {
            return true;
        }
    }
    return false;
}

Laszlo



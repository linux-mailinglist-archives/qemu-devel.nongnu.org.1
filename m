Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119E74EBBC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 12:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJAeM-0002ep-A2; Tue, 11 Jul 2023 06:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qJAeD-0002e3-4G; Tue, 11 Jul 2023 06:31:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qJAeB-00071E-If; Tue, 11 Jul 2023 06:31:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b9d80e33fbso12840875ad.0; 
 Tue, 11 Jul 2023 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689071465; x=1691663465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2oAf2Qhh2TrdXmZjGFPMLFQej/8J7W2ImL9J5i/284=;
 b=gf9qh8TRHgpIXmhIEXZD0K6QwxsoC9FT31zNGhL2yTeh2SSxjDJ2Z1JMnsxCt/aOdL
 AL9uJWGXz62l27WEa9Y1wg8rWlQjzjsZRgYfNlQURi+Rb94SlKAWfGQv3aDDFfCpXuE2
 RJ6o7IYG++M9GPIDm9AIBUTyJZM14Cvkavi1GgHfwpePWiFZ57isvObX5wYulcnVffMo
 ldNYTugzVXgegt55tpsMqTqZl18rNmRwWId/Yala6szYWxhkjsmamtYCaWsW0/xD8aFt
 e+RASI19p6IyQk5JbiL1G51za/J1ocz8i4vL5/aVa8y49B0pymoteOMer+FUku7NqoPl
 LzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689071465; x=1691663465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z2oAf2Qhh2TrdXmZjGFPMLFQej/8J7W2ImL9J5i/284=;
 b=laqv6YlzL+8upbhPaaFztxC1GckyxTxYh4TntyrdXgnxwka88WnibjVakSTDvelZVY
 B4TUpfX9ta4hmsL6MrtmtN6NhKc3W2utoo4XuYdU8IAowTfaf+TM4FfTlNdg7lxx++0B
 1sqIutFC1U8FQ/j+TjtcNhA6bRvi+Q1Px805LdoXvFaHOvZemYT3H5OKE/f+5rqggjBo
 fKhqERCf9p0zCj4iBaKSDv1OhsrBmHeo9mHWvRdWqIDw8n+7ChjBS4fywdigrx2OLVTm
 FUMrwl76/d+AdsQtwXJegCvtFb7f0BwVEvRcpg081RbK5b4LoGClQ3z0QJNTHLTZMjON
 Uxig==
X-Gm-Message-State: ABy/qLaKn1fPdbTBzwFtIMkXJu69/7o3aYV6m+0mauixB64sk64kIBkV
 sRc/0+vMyiLJcp1Unk6QMct0xGTD7n6Q5g==
X-Google-Smtp-Source: APBJJlHJtqbatx7ZT5VGWPA+QQLeg6CG1HdBWNal+C7M2L8a1NcALGvQwabG8luyc/SOlc/4cBv/Uw==
X-Received: by 2002:a17:902:cec3:b0:1b8:89fd:6213 with SMTP id
 d3-20020a170902cec300b001b889fd6213mr12408716plg.35.1689071464813; 
 Tue, 11 Jul 2023 03:31:04 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a1709026ac500b001b8918da8d1sm1541294plt.80.2023.07.11.03.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 03:31:04 -0700 (PDT)
Message-ID: <0e1a269c-0834-7255-1ded-0d37bddd1976@gmail.com>
Date: Tue, 11 Jul 2023 19:31:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: PING: [PATCH v4 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, hreitz@redhat.com, k.jensen@samsung.com,
 kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com, berrange@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <cover.1688459061.git.jeuk20.kim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,
Any more reviews...?

Dear Stefan
If you don't mind, Could you give it "reviewed-by"?
And is there anything else I should do...?

Thanks,
Jeuk

On 2023-07-04 오후 5:33, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
> 
> Since v3:
> - Replace softmmu_ss -> system_ss in meson
> 
> Since v2:
> Addressed review comment from Stefan Hajnoczi. The main fixes are as
> follows.
> - Use of SPDX licence identifiers
> - fixed endianness error
> - removed memory leak
> - fixed DMA error handling logic
> 
> Since v1:
> - use macros of "hw/registerfields.h" (Addressed Philippe's review
>    comments)
> 
> This patch series adds support for a new PCI-based UFS device.
> 
> The UFS pci device id (PCI_DEVICE_ID_REDHAT_UFS) is not registered
> in the Linux kernel yet, so it does not work right away, but I confirmed
> that it works with Linux when the UFS pci device id is registered.
> 
> I have also verified that it works with Windows 10.
> 
> Jeuk Kim (3):
>    hw/ufs: Initial commit for emulated Universal-Flash-Storage
>    hw/ufs: Support for Query Transfer Requests
>    hw/ufs: Support for UFS logical unit
> 
>   MAINTAINERS              |    6 +
>   docs/specs/pci-ids.rst   |    2 +
>   hw/Kconfig               |    1 +
>   hw/meson.build           |    1 +
>   hw/ufs/Kconfig           |    4 +
>   hw/ufs/lu.c              | 1441 +++++++++++++++++++++++++++++++++++
>   hw/ufs/meson.build       |    1 +
>   hw/ufs/trace-events      |   59 ++
>   hw/ufs/trace.h           |    1 +
>   hw/ufs/ufs.c             | 1545 ++++++++++++++++++++++++++++++++++++++
>   hw/ufs/ufs.h             |  131 ++++
>   include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
>   include/hw/pci/pci.h     |    1 +
>   include/hw/pci/pci_ids.h |    1 +
>   include/scsi/constants.h |    1 +
>   meson.build              |    1 +
>   16 files changed, 4244 insertions(+)
>   create mode 100644 hw/ufs/Kconfig
>   create mode 100644 hw/ufs/lu.c
>   create mode 100644 hw/ufs/meson.build
>   create mode 100644 hw/ufs/trace-events
>   create mode 100644 hw/ufs/trace.h
>   create mode 100644 hw/ufs/ufs.c
>   create mode 100644 hw/ufs/ufs.h
>   create mode 100644 include/block/ufs.h
> 



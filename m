Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F6744F67
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 19:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG1Go-0007QQ-Iq; Sun, 02 Jul 2023 13:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Gl-0007Pw-Mz; Sun, 02 Jul 2023 13:53:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qG1Gj-0003FB-Hi; Sun, 02 Jul 2023 13:53:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9EBA410DE7;
 Sun,  2 Jul 2023 20:53:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1BD7E111FD;
 Sun,  2 Jul 2023 20:53:47 +0300 (MSK)
Message-ID: <2bf22a3c-bd41-7d32-3543-196be206bc67@tls.msk.ru>
Date: Sun, 2 Jul 2023 20:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/2] vdpa: Refactor vdpa_feature_bits array
Content-Language: en-US
To: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com, mst@redhat.com, 
 eperezma@redhat.com, philmd@linaro.org
Cc: qemu-devel@nongnu.org, 18801353760@163.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <cover.1688130570.git.yin31149@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <cover.1688130570.git.yin31149@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

30.06.2023 16:21, Hawkins Jiawei wrote:
> This patchset removes the duplicated VIRTIO_NET_F_RSS entry
> in vdpa_feature_bits array and sorts the vdpa_feature_bits array
> alphabetically in ascending order to avoid future duplicates.
> 
> Changelog
> =========
> v3:
>    - sort array alphabetically suggested by Philippe
> 
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06764.html
>    - resolve conflicts with the master branch
> 
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01583.html
> 
> Hawkins Jiawei (2):
>    vdpa: Delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
>    vdpa: Sort vdpa_feature_bits array alphabetically
> 
>   net/vhost-vdpa.c | 40 +++++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 17 deletions(-)

Applied both to my trivial-patches tree, thank you!

/mjt



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327E763171
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 11:15:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOabi-0000uy-Gu; Wed, 26 Jul 2023 05:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOabf-0000ue-Ee; Wed, 26 Jul 2023 05:14:55 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOabd-0004UK-I8; Wed, 26 Jul 2023 05:14:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9a90:0:640:d8ed:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 7C09D5E514;
 Wed, 26 Jul 2023 12:14:39 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8924::1:1d] (unknown
 [2a02:6b8:b081:8924::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cEHHQ00OkiE0-hJTVnaXk; Wed, 26 Jul 2023 12:14:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690362878; bh=B+pgU+UjZyYBFaeZbUfDXkDIm/PadnQcxgtMT3TKDT8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=w4+mgE0kGDUsOouFtMg684nLPtq9iTRXomUoHQPSFGbgNo6aFedeeE+nYperFGClC
 5/qCakWIZjWWLDIEt8A1Op0VcjrJmfjWAqBC58E2SQcrJokgQ1D9T15R6y5nFN1xkf
 MzzFBHB2apF5jd2crXFalrdLd5PUj+25GB5q6MH4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2f2507df-8784-ba03-7224-c298b346a1f0@yandex-team.ru>
Date: Wed, 26 Jul 2023 12:14:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] block/io: align requests to subcluster_size
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org, 
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <20230711172553.234055-3-andrey.drobyshev@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230711172553.234055-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 11.07.23 20:25, Andrey Drobyshev wrote:
> When target image is using subclusters, and we align the request during
> copy-on-read, it makes sense to align to subcluster_size rather than
> cluster_size.  Otherwise we end up with unnecessary allocations.
> 
> This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
> and utilizes subcluster_size field of BlockDriverInfo to make necessary
> alignments.  It affects copy-on-read as well as mirror job (which is
> using bdrv_round_to_clusters()).
> 
> This change also fixes the following bug with failing assert (covered by
> the test in the subsequent commit):
> 
> qemu-img create -f qcow2 base.qcow2 64K
> qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
> qemu-io -c "write -P 0xaa 0 2K" img.qcow2
> qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2
> 
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> 
> Reviewed-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Denis V. Lunev<den@openvz.org>
> Signed-off-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



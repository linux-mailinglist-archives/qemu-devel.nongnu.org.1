Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86B7264BD
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vAs-0005to-8d; Wed, 07 Jun 2023 11:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6vAq-0005tc-2f
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:34:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6vAo-0000gE-8w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:34:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01F26B5C3;
 Wed,  7 Jun 2023 18:34:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5245BA546;
 Wed,  7 Jun 2023 18:34:05 +0300 (MSK)
Message-ID: <7f47a656-7304-4f89-c1dd-7c9d8969d838@tls.msk.ru>
Date: Wed, 7 Jun 2023 18:34:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] 9pfs: prevent opening special files (CVE-2023-2861)
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn
References: <E1q6tfP-0008VX-K3@lizzy.crudebyte.com>
 <20230607164950.2f4f6f39@bahia>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230607164950.2f4f6f39@bahia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

07.06.2023 17:50, Greg Kurz wrote:
> On Wed, 7 Jun 2023 15:50:01 +0200
..
>> +static inline int check_is_regular_file_or_dir(int fd)
>> +{
>> +    struct stat stbuf;
>> +
>> +    if (qemu_fstat(fd, &stbuf) < 0) {
>> +        close_preserve_errno(fd);
> 
> Maybe worth to mention somewhere that this function not only
> checks but also closes the fd if it doesn't point to a regular
> file or directory. Or maybe change the name, e.g.
> filter_out_special_files() ?

I realized this after sent initial comment, - my suggestion for
the name was awful. It is either check_is_regular() and close
after it failed, or it is ensure_regular_or_close().. But I
didn't sent a correction, hoping it's easy to spot the awful
suggestion.. :)

I don't like it when such a simple thing, especially when
reviewed without good care like in my case, generates so
much ping-pong.. :(

> Anyway the fix is fine enough to address the CVE.

Yeah.

/mjt



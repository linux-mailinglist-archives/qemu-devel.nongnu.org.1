Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A578D76FE69
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRs0D-0007OG-RQ; Fri, 04 Aug 2023 06:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRs0C-0007O1-OD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:25:48 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRs0B-0000vW-5P
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144743; x=1691749543; i=deller@gmx.de;
 bh=1iYZzpHvC/QSjPwpK0fKeBUmk172shF1PJTDotckjU8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KuvI9t7f/ygt2J55G4B3oe3cFfAOuogVaT3RWkxyXutKP4fLtjK63ksj3s050XBMOwaJmv8
 lrOmt1GCuCboqMZKlZsWY/2hGoh00TX57jpGMY5rDD43pQ6dWqHGT6NoliMBhFYLt8xx3vfSz
 WYV2MAALzl55jBoXE9erkF2iRAT4+dwnJDWL/UsrWA+sbdqD+4XSAjKuBOjoprilyklb6lbTf
 6XqFJ51OAylPKSVh9XfB1iXLLbQFdagm+42cdAu+iPGqn2osC8W/jHgL8HMb0SjFqk+tdZKQp
 Ydte4JIqPzS2njjxStKBKk2b5CGOc5rNRvaOi2yzjElVB2o/uFXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1q0Y7e0hzp-00jcNG; Fri, 04
 Aug 2023 12:25:43 +0200
Date: Fri, 4 Aug 2023 12:25:41 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 17/17] linux-user: Use zero_bss for PT_LOAD with no
 file contents too
Message-ID: <ZMzSJVlqME18GpL7@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-18-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-18-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:oYM0u5pASl1knaXesN/9oCvS1BrGrC7hXmwCh5Ly73Y2pwMEjZF
 +PilMkSrAdtgFd9KXqVAUbz5ky1v+cmoe5OGBK+F6tjQkQWbiRAThIAjj2QzEsTQ9W/24Tz
 Y2rN2Ih8jtNY6Zvlocs0XFAY3Re4xv8O7msHYLXjaUzUt5NZWm3T4OfK+O2c/k2F0ZGIg+x
 gzPWX2HyRmZCQPGUnwljA==
UI-OutboundReport: notjunk:1;M01:P0:GiFLCgyG9h4=;ltYDfnGbNmgRneJ8vRViOxbsUEK
 mFvyOlLhUPlQjp0c+yKvmaQd1NwpkI2o0kPALKIhwuF5uwqkxT/Dyde5U64R3qcR3t+90MNbH
 QXYXwYadqfGJfuEyh6gXqKXdUGEdJkxHfArSk9TnXjZJnZdNnwjYdyuus3ItlrMnR6oT5AxnQ
 b4JO9TUYhBnbHDXgDgo8rjviNc1JjGyBn6Z+doKqY/qQJ2gF7zWtsfo0BmdfOSZRCfJ2zfa9w
 uH3VbUecBliD8U9oP787OZTWzdsGtNg8MwNSN8fCiwTbN9j5h4ZG8FnONS/CTZX6Y5kKRvMPY
 vwhHZQtFPKBN9EqJeX/rD42UQn3+SN+fenDV5CTkSgmVh3YDdM0AT7mZUZxwi3CGENVFCjaaD
 4WOCYqVT4vVdnUuTbceelr0HPb47MvQdKedfny+9nSgNu/Yvm9F9e2A6bq9BpF/iD/8ek5ymh
 K+Sf3aZzr1IgmGqPKmVQIy4gdQwIxJYhoFKtvxfhG+FBO+buTNvUwCPrnkxwE5RTRoNKiu4tv
 KlvKcTs4ZyvNzfqvVv8J6cX987Kz+PAiQMbQDUjdkuZv8Jcf7u3VLRrgJLYZoA9GLtznTeyQ3
 /Pc5RIPGuj0cWe/u1NCigxa3XFOliY5d9+TWnbh1RzFh3eQh8wstuj6PtLT2Icn503O4yDAGP
 L8wqJwRNr5Ina+vRtirQmh4gOroGKdFxbmx4wcw04NOHZLvPiZA1AvMLprJl+92rTdFbBl8Vx
 QYXN8+xJaizkBhiX4Ycwtl4VnbRTMsFc/zMmbSoU3K4cInW0LFjffRZ3hEXe+TfAOI4vFrjvH
 +2e8ppdvM0SlMySsB554GKY5dc4K9g5CIzCDYWA0Z/bFoBhDZqfzvA6uwGl6LX6d3DkhvXsQe
 5mOpCJSSY8NAQwiu8C+ZWE/Z/FqZiTutBE3sEkAodUl/D2i+0LQFdh8cSMqce9buYvuhCdgGM
 HYpzqAFYRlRAxLy8kGQjdr/Dfd8=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> If p_filesz =3D=3D 0, then vaddr_ef =3D=3D vaddr.  We can reuse the
> code in zero_bss rather than incompletely duplicating it in
> load_elf_image.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


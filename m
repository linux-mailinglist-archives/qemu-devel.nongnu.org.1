Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74815793EAA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:23:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtQO-0005LE-7f; Wed, 06 Sep 2023 10:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qdtQL-0005C5-Qm
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qdtQB-0003GP-Lu
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLrPEIRUOqEQZCOMqd6lIkpLhk7vx962Vh5eJlSzPcA=;
 b=N6G3Xl3VplxR1Z1y5gTOaYr8LKoNMBmdZ1DEWYHMq8mbPVDPybmYeao1uAOKBHeYQOH8nK
 1w9Y6rVQ3FWNIZds8xdno/fsGjV4cBN4JWl5iDCn2XWYGUB12lWlMbEuVRFrTgVuFO/IQD
 4Pmnl6rJVMaUJEsHkHvq0khxpd8ONlg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-LLJKXwNFMLqC9xMGDVC27A-1; Wed, 06 Sep 2023 10:22:17 -0400
X-MC-Unique: LLJKXwNFMLqC9xMGDVC27A-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76ef8b91a84so83881785a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010136; x=1694614936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLrPEIRUOqEQZCOMqd6lIkpLhk7vx962Vh5eJlSzPcA=;
 b=Dao7DWPsd3benfskSbOaHlabmw1jvDgf6D2nLOQ0K2rL5KDkfAUlvlGsIicDWONZkv
 PlnOHVeqGCHPxoEJ93adSUJo9JcDuCM4xWHIAzBOTwPZXDWeCVIjzPMvYZCdpUzHnr0B
 0hT28ec9c6AZ7uTBnhwOrIWZnoVIWglw0X6LnkdDWNYv03AmWW6zQ8FsAuozyvMfRFey
 NtSmfgHkTVYVbg+nBC69ZXBkuBo23FJaGW9qu19PlkPxT2Z27AH5b9Rqb7g8vQ5HwOAz
 YVdliV4MXUKvB+qJAGI1AD9/Mt7orysaf9a3XWRWeaNsCDGei5fM/P2iGocD2Nv0e/e0
 KoZw==
X-Gm-Message-State: AOJu0YwJarGsIm857EhzI1LGS/hpNZ32ab+4CooS3bEuc+RYy65A6Zw8
 w7Xoxmvcl0p36U7GTggP/NpL7UZxtW1YJsRe8Oxi10wnZUIZ4ZGfeLpkCExVbAOUMWS37QW44Up
 EteIr2MMA9DCbMvE=
X-Received: by 2002:a05:620a:4012:b0:767:e994:ff03 with SMTP id
 h18-20020a05620a401200b00767e994ff03mr25184542qko.15.1694010136494; 
 Wed, 06 Sep 2023 07:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXUHwgQ7Gx7EVNfwIXcBNC9rLE0HvM68ZL2S/sk+boIPMfhhx3JIB+vkFOZLYcwaS5uEdf5A==
X-Received: by 2002:a05:620a:4012:b0:767:e994:ff03 with SMTP id
 h18-20020a05620a401200b00767e994ff03mr25184516qko.15.1694010136212; 
 Wed, 06 Sep 2023 07:22:16 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.232.23])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05620a074200b007676f3859fasm5010064qki.30.2023.09.06.07.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 07:22:15 -0700 (PDT)
Date: Wed, 6 Sep 2023 16:22:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] subprojects: add wrap file for libblkio
Message-ID: <npcr4k2cnmjgrr242jls3l3fmt6wucceu4euqcfrlj4ir264pi@urufyyqfbnc5>
References: <20230906104529.401824-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230906104529.401824-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Sep 06, 2023 at 12:45:29PM +0200, Paolo Bonzini wrote:
>This allows building libblkio at the same time as QEMU, if QEMU is
>configured with --enable-blkio --enable-download.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> subprojects/libblkio.wrap | 6 ++++++
> 1 file changed, 6 insertions(+)
> create mode 100644 subprojects/libblkio.wrap
>
>diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
>new file mode 100644
>index 00000000000..f77af72210c
>--- /dev/null
>+++ b/subprojects/libblkio.wrap
>@@ -0,0 +1,6 @@
>+[wrap-git]
>+url = https://gitlab.com/libblkio/libblkio
>+revision = f84cc963a444e4cb34813b2dcfc5bf8526947dc0
>+
>+[provide]
>+blkio = libblkio_dep
>-- 
>2.41.0
>
>

I'm trying it in a clean container and I have this issue:

   HEAD is now at f84cc96 allow building libblkio as a subproject

   Executing subproject libblkio

   ../subprojects/libblkio/meson.build:1:0: ERROR: Command `/root/qemu/subprojects/libblkio/./package-version.py` failed with status 1.

   A full log can be found at /root/qemu/build/meson-logs/meson-log.txt

   ERROR: meson setup failed


Looking in the meson-log.txt, I have this:

   Package 'blkio', required by 'virtual:world', not found
   -----------
   Run-time dependency blkio found: NO (tried pkgconfig)
   Looking for a fallback subproject for the dependency blkio

   Executing subproject libblkio

   Running command: /root/qemu/subprojects/libblkio/./package-version.py
   --- stdout ---

   --- stderr ---
   Traceback (most recent call last):
     File "/root/qemu/subprojects/libblkio/./package-version.py", line 5, in <module>
       out = subprocess.check_output(["cargo", "read-manifest"])
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     File "/usr/lib64/python3.11/subprocess.py", line 466, in check_output
       return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     File "/usr/lib64/python3.11/subprocess.py", line 548, in run
       with Popen(*popenargs, **kwargs) as process:
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
     File "/usr/lib64/python3.11/subprocess.py", line 1026, in __init__
       self._execute_child(args, executable, preexec_fn, close_fds,
     File "/usr/lib64/python3.11/subprocess.py", line 1950, in _execute_child
       raise child_exception_type(errno_num, err_msg, err_filename)
   FileNotFoundError: [Errno 2] No such file or directory: 'cargo'

Installing `cargo` fixed the issue on my side.
I don't know if it is possible, but can we put some dependecy check in
the wrap file?

Anyway, after installing cargo it works pretty well :-)

Tested-by: Stefano Garzarella <sgarzare@redhat.com>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8107DCD32
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 13:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoAX-00048T-KR; Tue, 31 Oct 2023 08:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ReneEngel80@emailn.de>)
 id 1qxkWF-0006DC-3O
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:54:39 -0400
Received: from mail.emailn.de ([46.182.21.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ReneEngel80@emailn.de>)
 id 1qxkWD-0005Ud-4t
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:54:38 -0400
Received: from mail.emailn.de (192.168.0.32 [192.168.0.32])
 by mail.emailn.de (b1gMailServer) with ESMTP id 71332AF4
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:54:32 +0100 (CET)
Date: Tue, 31 Oct 2023 09:54:32 +0100
MIME-Version: 1.0
Message-ID: <87cfa6e91ba9608c5f4cd0841987925d@mail.emailn.de>
X-Mailer: b1gMail/7.2.0
X-Sender-IP: 79.233.215.135
From: "Rene Engel" <ReneEngel80@emailn.de>
Subject: qemu master git source can not compile under macOS Sonoma 14.1
To: qemu-devel@nongnu.org
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=46.182.21.2; envelope-from=ReneEngel80@emailn.de;
 helo=mail.emailn.de
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 31 Oct 2023 08:48:22 -0400
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
Reply-To: Rene Engel <ReneEngel80@emailn.de>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

<html><div>Hello,</div><div><br></div><div>For days I've been trying to compile qemu master git 8.1.50 from the current qemu sources under MacOs Sonoma, which fails. Older sources can be compiled without any problems, there seems to be a problem with Meson in the last source, version 0.63.3 is always tried to be used. Meson 1.2.3 is installed on my system via Homebrew.</div><div><br></div><div>I have already described the problem here:</div><div><br></div><div>https://gitlab.com/qemu-project/qemu/-/issues/1939</div><div><br></div><div>But unfortunately there has been no solution to the problem so far and so I ask for further help with the problem. Meson log:</div><div><br></div><div><div>Build started at 2023-10-31T09:29:38.493540</div><div>Main binary: /Users/reneengel/qemu/build/pyvenv/bin/python3</div><div>Build Options: -Db_pie=false -Ddocs=disabled -Dplugins=true '--native-file config-meson.cross'</div><div>Python
system: Darwin</div><div>The Meson build system</div><div>Version: 0.63.3</div><div>Source dir: /Users/reneengel/qemu</div><div>Build dir: /Users/reneengel/qemu/build</div><div>Build type: native build</div><div>Project name: qemu</div><div>Project version: 8.1.50</div><div>-----</div><div>Detecting compiler via: cc --version</div><div>compiler returned &lt;Popen: returncode: 0 args: ['cc', '--version']&gt;</div><div>compiler stdout:</div><div>Apple clang version 15.0.0 (clang-1500.0.40.1)</div><div>Target: arm64-apple-darwin23.1.0</div><div>Thread model: posix</div><div>InstalledDir: /Library/Developer/CommandLineTools/usr/bin</div><div><br></div><div>compiler stderr:</div><div><br></div><div>Running command: cc -E -dM -</div><div>-----</div><div>Detecting linker via: cc -Wl,--version</div><div>linker returned &lt;Popen: returncode: 1 args: ['cc', '-Wl,--version']&gt;</div><div>linker stdout:</div><div><br></div><div>linker
stderr:</div><div>ld: unknown options: --version&nbsp;</div><div>clang: error: linker command failed with exit code 1 (use -v to see invocation)</div><div><br></div><div>-----</div><div>Detecting Apple linker via: cc -Wl,-v</div><div>linker stdout:</div><div><br></div><div>linker stderr:</div><div>@(#)PROGRAM:ld &nbsp;PROJECT:dyld-1015.7</div><div>BUILD 18:48:48 Aug 22 2023</div><div>configured to support archs: armv6 armv7 armv7s arm64 arm64e arm64_32 i386 x86_64 x86_64h armv6m armv7k armv7m armv7em</div><div>will use ld-classic for: armv6 armv7 armv7s arm64_32 i386 armv6m armv7k armv7m armv7em</div><div>LTO support using: LLVM version 15.0.0 (static support for 29, runtime is 29)</div><div>TAPI support using: Apple TAPI version 15.0.0 (tapi-1500.0.12.3)</div><div>Library search paths:</div><div><span class="Apple-tab-span" style="white-space:pre">	</span>/usr/local/lib</div><div>Framework
search paths:</div><div>ld: Undefined symbols:</div><div>&nbsp; _main, referenced from:</div><div>&nbsp; &nbsp; &nbsp; &lt;initial-undefines&gt;</div><div>clang: error: linker command failed with exit code 1 (use -v to see invocation)</div><div><br></div><div><br></div><div>../meson.build:1:0: ERROR: Unable to detect linker for compiler `cc -Wl,--version`</div><div>stdout:&nbsp;</div><div>stderr: ld: unknown options: --version&nbsp;</div><div>clang: error: linker command failed with exit code 1 (use -v to see invocation)</div><div><br></div></div><div><br></div><div>lg Rene&nbsp;</div><br /><br />
<hr /><br />
Versendet mit <a href="https://www.emailn.de/">Emailn.de</a> - Freemail
<br /><br />
* Unbegrenzt Speicherplatz<br />
* Eigenes Online-Büro<br />
* 24h besten Mailempfang<br />
* Spamschutz, Adressbuch <br /><br /></html>




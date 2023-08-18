Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CA780518
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 06:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWr1A-0002Qf-RR; Fri, 18 Aug 2023 00:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qWr15-0002Ol-11
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 00:23:19 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qWr12-0003jq-EE
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 00:23:18 -0400
Received: from [192.168.8.104] (unknown [94.25.229.58])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6A34F40F1DE1;
 Fri, 18 Aug 2023 04:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6A34F40F1DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1692332593;
 bh=GJAiuw8h1BHAc4YGuwsuh4TrNHigJRjM5xHQIGyj/RI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eoWWdY2JB1iOZtUQW6pErv0zXcik9RrVSB5PRswq8+yMjOeS0r41fed07uTrRHUyj
 G0ZYnXNRXjLWgq/jAebtR0nBin6ST4sX67/IOhMApdMXSbiEE2U46uVi5OQAWsXhbB
 s0V0MC21VnK2Z7/6tTGx9bvUb3QIu8yl5anAEehc=
Message-ID: <7af8a4f7-06f8-436f-e125-d6389fcdbbda@ispras.ru>
Date: Fri, 18 Aug 2023 07:23:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] tests/avocado: replay_linux.py add replay-dump.py test
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-3-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230814163135.187882-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 14.08.2023 19:31, Nicholas Piggin wrote:
> This runs replay-dump.py after recording a trace, and fails the test if
> the script fails.
> 
> replay-dump.py is modified to exit with non-zero if an error is
> encountered while parsing.

I would like to have separate test for replay-dump, because
replay-linux tests are very heavy to replay and knowing the exact
reason of the failure in advance would be more convenient.

What do you think of splitting the test?

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> It's possible this could introduce failures to existing test if an
> unimplemented event gets recorded. I would make a new test for this but
> it takes quite a while to record such a long trace that includes some
> block and net events to excercise the script.
> 
> Thanks,
> Nick
> 
>   scripts/replay-dump.py        |  6 ++++--
>   tests/avocado/replay_linux.py | 16 +++++++++++++++-
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index 937ae19ff1..8f4715632a 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -21,6 +21,7 @@
>   import argparse
>   import struct
>   import os
> +import sys
>   from collections import namedtuple
>   
>   # This mirrors some of the global replay state which some of the
> @@ -97,7 +98,7 @@ def call_decode(table, index, dumpfile):
>           print("Could not decode index: %d" % (index))
>           print("Entry is: %s" % (decoder))
>           print("Decode Table is:\n%s" % (table))
> -        return False
> +        sys.exit(1)
>       else:
>           return decoder.fn(decoder.eid, decoder.name, dumpfile)
>   
> @@ -118,7 +119,7 @@ def print_event(eid, name, string=None, event_count=None):
>   def decode_unimp(eid, name, _unused_dumpfile):
>       "Unimplimented decoder, will trigger exit"
>       print("%s not handled - will now stop" % (name))
> -    return False
> +    sys.exit(1)
>   
>   # Checkpoint decoder
>   def swallow_async_qword(eid, name, dumpfile):
> @@ -401,3 +402,4 @@ def decode_file(filename):
>   if __name__ == "__main__":
>       args = parse_arguments()
>       decode_file(args.file)
> +    sys.exit(0)
> diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
> index a76dd507fc..12937ce0ec 100644
> --- a/tests/avocado/replay_linux.py
> +++ b/tests/avocado/replay_linux.py
> @@ -11,6 +11,7 @@
>   import os
>   import logging
>   import time
> +import subprocess
>   
>   from avocado import skipUnless
>   from avocado_qemu import BUILD_DIR
> @@ -21,6 +22,11 @@
>   from avocado.utils.path import find_command
>   from avocado_qemu import LinuxTest
>   
> +from pathlib import Path
> +
> +self_dir = Path(__file__).parent
> +src_dir = self_dir.parent.parent
> +
>   class ReplayLinux(LinuxTest):
>       """
>       Boots a Linux system, checking for a successful initialization
> @@ -94,7 +100,7 @@ def launch_and_wait(self, record, args, shift):
>           else:
>               vm.event_wait('SHUTDOWN', self.timeout)
>               vm.shutdown(True)
> -            logger.info('successfully fihished the replay')
> +            logger.info('successfully finished the replay')
>           elapsed = time.time() - start_time
>           logger.info('elapsed time %.2f sec' % elapsed)
>           return elapsed
> @@ -105,6 +111,14 @@ def run_rr(self, args=None, shift=7):
>           logger = logging.getLogger('replay')
>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>   
> +        try:
> +            replay_path = os.path.join(self.workdir, 'replay.bin')
> +            subprocess.check_call(["./scripts/replay-dump.py",
> +                                   "-f", replay_path],
> +                                  cwd=src_dir, stdout=subprocess.DEVNULL)
> +        except subprocess.CalledProcessError:
> +            self.fail('replay-dump.py failed')
> +
>   @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>   class ReplayLinuxX8664(ReplayLinux):
>       """


